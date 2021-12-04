//
//  MainTableViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class MainTableViewController: UITableViewController, imageSelectedProtocol {
    
//    MARK: ReuseIdentifier
    private let userNameCell = "userNameCell"
    private let takeSelfieCell = "takeSelfieCell"
    private let desciptionCell = "desciptionCell"
    private let doneCell = "doneCell"
    
//    MARK: Var
    var searchResult: SearchResult?
    var popup: PopupViewController?
    var userName: String?
    var imageUpload: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        registerCell()
        fetchData()
    }
    
//    MARK: Register cells
    func registerCell(){
        tableView.register(UINib(nibName: "UserNameCell", bundle: nil), forCellReuseIdentifier: userNameCell)
        tableView.register(UINib(nibName: "TakeSelfieCell", bundle: nil), forCellReuseIdentifier: takeSelfieCell)
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: desciptionCell)
        tableView.register(UINib(nibName: "DoneCell", bundle: nil), forCellReuseIdentifier: doneCell)
    }
    
    func showPopup(){
        self.popup = PopupViewController()
        self.popup?.delegateImage =  self
        self.popup?.view.frame = self.tableView.frame
        self.view.addSubview((self.popup?.view)!)
        self.addChild(self.popup!)
    }
    
    func imageSelected(image: Data) {
        
    }
    
    func fetchData(){
        self.showOverlay("Cargando...")
        Network.shared.fetchGenericJSONData(urlString: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld") { (result: SearchResult?, error) in
            if error != nil{
                self.errorMessage(title: "¡Error!", message: "No se pudo obtener los datos del servicio.")
            }
            self.searchResult = result
            DispatchQueue.main.async{
                self.hideOverlay()
            }
        }
    }
    
    func errorMessage(title: String, message: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - Table view data source
extension MainTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainTableView.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case MainTableView.userNameCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: userNameCell, for: indexPath) as! UserNameCell
            cell.handlerString = { userName in
                self.userName = userName
            }
            return cell
        case MainTableView.takeSelfieCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: takeSelfieCell, for: indexPath) as! TakeSelfieCell
            return cell
        case MainTableView.desciptionCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: desciptionCell, for: indexPath) as! DescriptionCell
            return cell
        case MainTableView.doneCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: doneCell, for: indexPath) as! DoneCell
            cell.handlerClickDone = {
                print("Click Done")
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == MainTableView.desciptionCell{
            return 400
        } else if indexPath.row == MainTableView.doneCell {
            return 75
        }
        return MainTableView.Heights.default
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let row = indexPath.row
        switch row {
        case MainTableView.takeSelfieCell:
            self.showPopup()
        default:
            break
        }
    }
}
