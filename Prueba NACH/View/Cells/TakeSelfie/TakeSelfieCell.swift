//
//  TakeSelfieCell.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class TakeSelfieCell: UITableViewCell {
    
    var handlerSelected: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        handlerSelected?()
    }
}
