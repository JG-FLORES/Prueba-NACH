//
//  MainTableView.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

public struct MainTableView{
    static let numberOfRows: Int = 4
    static let userNameCell: Int = 0
    static let takeSelfieCell: Int = 1
    static let desciptionCell: Int = 2
    static let doneCell: Int = 3
    
    struct Heights {
        static let desciption:CGFloat = 400
        static let done:CGFloat = 75
        static let `default`:CGFloat = 100
    }
}
