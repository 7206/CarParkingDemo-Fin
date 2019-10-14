//
//  PaymentMethodViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//
//sandbox_v2gsrf62_wf93b3g2kcx7t3wk
import UIKit
import PassKit
import Braintree
import Stripe

class PaymentVC: UIViewController {
    var paymentSucceeded = false
var braintreeClient: BTAPIClient!

   
    @IBOutlet weak var backbtnoutlet: UIButton!
    
    @IBOutlet weak var paypalbtnoutlet: LoadingButton!
    @IBOutlet weak var applepaybtnoutlet: LoadingButton!
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        braintreeClient = BTAPIClient(authorization: "sandbox_jytpjsfm_wf93b3g2kcx7t3wk")
       
    
    }
    @IBAction func applepaybtn(_ sender: UIButton) {
       // applePayController?.delegate = self
        func handleApplePayButtonTapped() {
            let merchantIdentifier = "merchant.com.example.stripeDemo"
            let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")
            
            // Configure the line items on the payment request
            paymentRequest.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Fancy Hat", amount: 50.00),
                // The final line should represent your company;
                // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
                PKPaymentSummaryItem(label: "iHats, Inc", amount: 50.00),
            ]
            if Stripe.canSubmitPaymentRequest(paymentRequest),
                let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                paymentAuthorizationViewController.delegate = self
                present(paymentAuthorizationViewController, animated: true)
            } else {
                // There is a problem with your Apple Pay configuration
            }
            // ...continued in next step
        }
        
//        let request = PKPaymentRequest()
//        request.merchantIdentifier = "merchant.com.example.stripeDemo"
//        request.supportedNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
//        request.merchantCapabilities = PKMerchantCapability.capability3DS
//        request.countryCode = "US"
//        request.currencyCode = "USD"
//
//        request.paymentSummaryItems = [
//            PKPaymentSummaryItem(label: "Some Product", amount: 9.99)
//        ]
//
//        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
//        self.present(applePayController!, animated: true, completion: nil)
//        applePayController?.delegate = self
    }
    
    @IBAction func paypalbtn(_ sender: Any) {
         self.paypalbtnoutlet.showLoading()
        paypalbtn()
    }
    func paypalbtn(){
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
        payPalDriver.viewControllerPresentingDelegate = self
          payPalDriver.appSwitchDelegate = self  // Optional
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalRequest(amount: "2.32")
        request.currencyCode = "INR" // Optional; see BTPayPalRequest.h for more options
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                
                // Access additional information
                //                let email = tokenizedPayPalAccount.email
                //                debugPrint(email)
                //                let firstName = tokenizedPayPalAccount.firstName
                //                let lastName = tokenizedPayPalAccount.lastName
                //                let phone = tokenizedPayPalAccount.phone
                //
                //                // See BTPostalAddress.h for details
                //                let billingAddress = tokenizedPayPalAccount.billingAddress
                //                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
                print(error)
                self.paypalbtnoutlet.hideLoading()
            } else {
                self.paypalbtnoutlet.hideLoading()
                // Buyer canceled payment approval
            }
        }
    }
    }
    // PayPalPaymentDelegate
   


extension PaymentVC: PKPaymentAuthorizationViewControllerDelegate, STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Convert the PKPayment into a PaymentMethod
        STPAPIClient.shared().createPaymentMethod(with: payment) { (paymentMethod: STPPaymentMethod?, error: Error?) in
            guard let paymentMethod = paymentMethod, error == nil else {
                // Present error to customer...
                return
            }
            let clientSecret = "sk_test_GakPH3pf3ALEGLEAiz51PMcA00QQUBB1LS"
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            paymentIntentParams.paymentMethodId = paymentMethod.stripeId
            
            // Confirm the PaymentIntent with the payment method
            STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
                switch (status) {
                case .succeeded:
                    // Save payment success
                    self.paymentSucceeded = true
                    handler(PKPaymentAuthorizationResult(status: .success, errors: nil))
                case .canceled:
                    handler(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                case .failed:
                    // Save/handle error
                    let errors = [STPAPIClient.pkPaymentError(forStripeError: error)].compactMap({ $0 })
                    handler(PKPaymentAuthorizationResult(status: .failure, errors: errors))
                @unknown default:
                    handler(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                }
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        // Dismiss payment authorization view controller
        dismiss(animated: true, completion: {
            if (self.paymentSucceeded) {
                // Show a receipt page...
            } else {
                // Present error to customer...
            }
        })
    }
}

extension PaymentVC : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension PaymentVC : BTAppSwitchDelegate {
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
