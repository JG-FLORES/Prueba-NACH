//
//  MainTableViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit
import Firebase

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
        observeData()
    }
    
//    MARK: Register cells
    func registerCell(){
        tableView.register(UINib(nibName: "UserNameCell", bundle: nil), forCellReuseIdentifier: userNameCell)
        tableView.register(UINib(nibName: "TakeSelfieCell", bundle: nil), forCellReuseIdentifier: takeSelfieCell)
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: desciptionCell)
        tableView.register(UINib(nibName: "DoneCell", bundle: nil), forCellReuseIdentifier: doneCell)
    }
    
//    MARK: Show popup
    func showPopup(){
        self.popup = PopupViewController()
        self.popup?.delegateImage =  self
        self.popup?.view.frame = self.tableView.frame
        self.view.addSubview((self.popup?.view)!)
        self.addChild(self.popup!)
    }
    
    func imageSelected(image: Data) {
        imageUpload = image
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
    
//    MARK: Fetch Data
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
            return MainTableView.Heights.desciption
        } else if indexPath.row == MainTableView.doneCell {
            return MainTableView.Heights.done
        }
        return MainTableView.Heights.default
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        switch indexPath.row {
        case MainTableView.takeSelfieCell:
            self.showPopup()
        default:
            break
        }
    }
}
