//
//  UIViewController+extension.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

extension UIViewController {
    func showOverlay(_ title: String){
        Overlay.shared.showOverlayBasic(self.view, title)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideOverlay(){
        Overlay.shared.hideOverlay()
        self.view.isUserInteractionEnabled = true
    }
}
