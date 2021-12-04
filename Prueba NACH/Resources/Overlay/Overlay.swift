//
//  Overlay.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

open class Overlay{
    
    class var shared: Overlay {
        struct Static {
            static let instance: Overlay = Overlay()
        }
        return Static.instance
    }
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var labeTitle = UILabel()
        
    open func showOverlayBasic(_ view: UIView,_ title: String){
        //creating overlay
        overlayView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 14.0
        overlayView.clipsToBounds = true
        
        //creating activityIndicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2 - 10)
        activityIndicator.color = .white
        
        //Creating label for tittle
        labeTitle.frame = CGRect(x: 0, y: 0, width: 96, height: 20)
        labeTitle.text = title
        labeTitle.font = UIFont(name: "Poppins-SemiBold", size: 15)
        labeTitle.textColor = UIColor.white
        labeTitle.textAlignment = NSTextAlignment.center
        labeTitle.sizeToFit()
        labeTitle.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2 + 32)
        
        
        //adding subviews
        overlayView.addSubview(activityIndicator)
        overlayView.addSubview(labeTitle)
        view.addSubview(overlayView)
        
        overlayView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        
        //adding constraint
        overlayView.setupConstraintCenterInSuperview(size: .init(width: 125, height: 125))
    }
    
    open func hideOverlay(){
        //remove views
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

