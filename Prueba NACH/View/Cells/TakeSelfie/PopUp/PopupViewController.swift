//
//  PopupViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit
import Photos

// MARK: Protocol
protocol imageSelectedProtocol {
    func imageSelected(image: Data)
}

class PopupViewController: UIViewController {

    @IBOutlet weak var viewAllContainer: UIView!
    @IBOutlet weak var viewContainerElements: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
//    MARK: Var
    var delegateImage: imageSelectedProtocol?
    let imgPickierController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        viewContainerElements.layer.cornerRadius = 13
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewAllContainerTapped))
        viewAllContainer.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func viewAllContainerTapped() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    @IBAction func openCamera(_ sender: Any) {
        checkCameraPermission()
    }
    
    @IBAction func openGalery(_ sender: Any) {
        checkPhotoLibraryPermission()
    }
}

//MARK: Delegate
extension PopupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
 
    func errorMessage(type: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: type, message: "Es necesario activar los permisos de \(type)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Ir a configuración", style: .default, handler: { action in
                if #available(iOS 10.0, *) {
                    let settingsURL = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: {(success) in
                         
                    })
                } else {
                    if let url = NSURL(string:UIApplication.openSettingsURLString) {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
              }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
           self.openGallery()
        case .denied, .restricted:
            self.errorMessage(type: "Galería")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.openGallery()
                case .denied, .restricted:
                    self.errorMessage(type: "Galería")
                case .notDetermined, .limited: break
                @unknown default:
                    fatalError()
                }
            }
        case .limited: break
        @unknown default:
            fatalError()
        }
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.openCamera()
        case .denied, .restricted:
            self.errorMessage(type: "Cámara")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    self.openCamera()
                } else {
                    self.errorMessage(type: "Cámara")
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    func openGallery(){
        DispatchQueue.main.async {
            self.imgPickierController.sourceType = .photoLibrary
            self.imgPickierController.allowsEditing = true
            self.imgPickierController.delegate = self
            self.present(self.imgPickierController, animated: true, completion: nil)
        }
    }
    
    func openCamera(){
        DispatchQueue.main.async {
            self.imgPickierController.sourceType = .camera
            self.imgPickierController.allowsEditing = true
            self.imgPickierController.delegate = self
            self.present(self.imgPickierController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.imageView.image = image
            guard let dataImage = image.pngData() else{ return }
            self.delegateImage?.imageSelected(image: dataImage)
        }
        self.dismiss(animated: true, completion:nil)
    }
}
