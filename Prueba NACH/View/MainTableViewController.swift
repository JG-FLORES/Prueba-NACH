//
//  MainTableViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class MainTableViewController: UITableViewController {
    
//    MARK: ReuseIdentifier
    private let userNameCell = "userNameCell"
    private let takeSelfieCell = "takeSelfieCell"
    private let descriptionCell = "descriptionCell"
    private let doneCell = "doneCell"
    private let complementCell = "complementCell"
    
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
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: descriptionCell)
        tableView.register(UINib(nibName: "DoneCell", bundle: nil), forCellReuseIdentifier: doneCell)
        tableView.register(UINib(nibName: "ComplementCell", bundle: nil), forCellReuseIdentifier: complementCell)
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
        case MainTableView.descriptionCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCell, for: indexPath) as! DescriptionCell
            return cell
        case MainTableView.doneCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: doneCell, for: indexPath) as! DoneCell
            cell.handlerClickDone = {
                self.uploadImage()
            }
            return cell
        case MainTableView.complementCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: complementCell, for: indexPath) as! ComplementCell
            cell.handlerClick = {
                self.navigateToPDFViewer()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == MainTableView.descriptionCell{
            return MainTableView.Heights.description
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
        case MainTableView.descriptionCell:
            self.navigateToGraph()
        default:
            break
        }
    }
}
