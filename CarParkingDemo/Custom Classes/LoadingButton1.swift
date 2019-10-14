//
//  LoadingButton.swift
//  CarParkingDemo
//
//  Created by admin on 20/09/19.
//  Copyright © 2019 admin. All rights reserved.


import Foundation
import UIKit
class LoadingButton1: UIButton {
    
    var originalButtonText: String?
    var orignalimage:UIImage?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: UIControl.State.normal)
        
        orignalimage = self.imageView?.image
        self.setImage(nil, for: UIControl.State.normal)
        
        
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: UIControl.State.normal)
        self.setImage(orignalimage, for: UIControl.State.normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        
        // activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
