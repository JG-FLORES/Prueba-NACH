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
        
    
//    MARK: Var
    var popup: PopupViewController?
    var userName: String?
    var imageUpload: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.tableView.backgroundColor = .red
    }
    
//    MARK: Register cells
    func registerCell(){
        tableView.register(UINib(nibName: "UserNameCell", bundle: nil), forCellReuseIdentifier: userNameCell)
        tableView.register(UINib(nibName: "TakeSelfieCell", bundle: nil), forCellReuseIdentifier: takeSelfieCell)
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: desciptionCell)
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
}

// MARK: - Table view data source
extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "userNameCell", for: indexPath) as! UserNameCell
            cell.handlerString = { userName in
                self.userName = userName
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "takeSelfieCell", for: indexPath) as! TakeSelfieCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "desciptionCell", for: indexPath) as! DescriptionCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return 400
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let row = indexPath.row
        switch row {
        case 1:
            self.showPopup()
        default:
            break
        }
    }
}
