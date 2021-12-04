//
//  TableView.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

public struct MainTableView {
    static let numberOfRows: Int = 5
    
    static let userNameCell: Int = 0
    static let takeSelfieCell: Int = 1
    static let descriptionCell: Int = 2
    static let doneCell: Int = 3
    static let complementCell: Int = 4
    
    struct Heights {
        static let description:CGFloat = 400
        static let done:CGFloat = 75
        static let `default`:CGFloat = 65
    }
}

public struct GraphTableView {
    struct Heights {
        static let `default`:CGFloat = 500
    }
}
