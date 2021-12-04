//
//  ComplementCell.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 04/12/21.
//

import UIKit

class ComplementCell: UITableViewCell {

//    MARK: Var
    var handlerClick: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func goPdfViewer(_ sender: Any) {
        handlerClick?()
    }
    
}
