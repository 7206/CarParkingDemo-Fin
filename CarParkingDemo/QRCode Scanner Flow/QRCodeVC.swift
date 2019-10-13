//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit

struct QRData {
    var codeString: String?
}


class QRCodeVC: UIViewController {
    @IBOutlet weak var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    @IBOutlet weak var scanButton: UIButton! {
        didSet {
            scanButton.setTitle("", for: .normal)
        }
    }
    
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                self.performSegue(withIdentifier: "detailSeuge", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    @IBAction func back(_ sender: UIButton) {
        showloader = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.isRunning ? scannerView.stopScanning() : scannerView.startScanning()
        let buttonTitle = scannerView.isRunning ? "" : ""
        sender.setTitle(buttonTitle, for: .normal)
    }
}


extension QRCodeVC: QRScannerViewDelegate {
    func qrScanningDidStop() {
        let buttonTitle = scannerView.isRunning ? "" : ""
        scanButton.setTitle(buttonTitle, for: .normal)
    }
    
    func qrScanningDidFail() {
      //  presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
    }
    
    
    
}


extension QRCodeVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QRCodeDetailVC", let viewController = segue.destination as? QRCodeDetailVC {
           // viewController.qrData = self.qrData
        }
    }
}

