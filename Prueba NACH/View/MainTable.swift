//
//  MainTable.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit
import Firebase


extension MainTableViewController: imageSelectedProtocol {
    
    func imageSelected(image: Data) {
        imageUpload = image
    }
    
//    MARK: Show popup
    func showPopup(){
        self.popup = PopupViewController()
        self.popup?.delegateImage =  self
        self.popup?.modalPresentationStyle = .fullScreen
        self.popup?.view.frame = self.tableView.frame
        self.view.addSubview((self.popup?.view)!)
        self.addChild(self.popup!)
    }
    
//    MARK: Observe Data Base Real Time
    func observeData(){
        Database.database().reference(withPath: "backgroundColor").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? [String: AnyObject] else { return }
            guard let r = value["r"] as? Int, let g = value["g"] as? Int, let b = value["b"] as? Int else { return }
            
            let red = CGFloat(r)
            let green = CGFloat(g)
            let blue = CGFloat(b)
            let color = UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
            self.tableView.backgroundColor = color
        }
    }
    
//    MARK: Upload taked image
    func uploadImage(){
        if let nameUser = userName {
            guard let data = imageUpload else {
                self.showMessage(title: "¡Atención!", message: "Es necesario agregues una imagen.")
                return
            }
            let imageName = nameUser.replacingOccurrences(of: " ", with: "-")
            let storageRef = Storage.storage().reference()
            let riversRef = storageRef.child("Imagenes/\(imageName).png")
            self.showOverlay("Subiendo...")
            DispatchQueue.main.async {
                riversRef.putData(data, metadata: nil) { (_, error) in
                    DispatchQueue.main.async {
                        self.hideOverlay()
                        guard error == nil else{
                            self.showMessage(title: "¡Error!", message: "Hubo un error en la carga de la imagen.")
                            return
                        }
                        self.imageUpload = nil
                        self.userName = nil
                        self.showMessage(title: "¡Listo!", message: "Se ha subido la imagen correctamente.")
                    }
                }
            }
        }else {
            self.showMessage(title: "¡Atención!", message: "Es necesario que escribas tu nombre")
        }
    }
    
//    MARK: Fetch Data
    func fetchData(){
        self.showOverlay("Cargando...")
        Network.shared.fetchGenericJSONData(urlString: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld") { (result: SearchResult?, error) in
            if error != nil{
                self.showMessage(title: "¡Error!", message: "No se pudo obtener los datos del servicio.")
            }
            self.searchResult = result
            DispatchQueue.main.async{
                self.hideOverlay()
            }
        }
    }
    
//    MARK: Show Alert
    func showMessage(title: String, message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
//    MARK: Navigate to Graph
    func navigateToGraph(){
        guard let result = searchResult else { return }
        let graphController = GraphTableViewController()
        graphController.searchResult = result
        self.navigationController?.pushViewController(graphController, animated: true)
    }
    
//    MARK: Navigate to PDF Viewer
    func navigateToPDFViewer(){
        let pdfViewer = PDFViewerViewController()
        self.navigationController?.pushViewController(pdfViewer, animated: true)
    }
}
