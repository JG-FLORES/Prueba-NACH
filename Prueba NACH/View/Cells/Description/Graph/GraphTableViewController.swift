//
//  GraphTableViewController.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class GraphTableViewController: UITableViewController {

//    MARK: Var
    var searchResult: SearchResult?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Table view data source
extension GraphTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.questions.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GraphTableView.Heights.default
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let graph = GraphViewController()
        let question = self.searchResult?.questions[indexPath.row]
        graph.questions = question
        graph.view.frame = cell.frame
        cell.addSubview(graph.view)
        return cell
    }
}
