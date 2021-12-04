//
//  DoneCell.swift
//  Prueba NACH
//
//  Created by IDS Comercial on 03/12/21.
//

import UIKit

class DoneCell: UITableViewCell {
    
    @IBOutlet weak var btnDone: UIButton!
    var handlerClickDone: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView(){
        btnDone.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func done(_ sender: Any) {
        handlerClickDone?()
    }
    
}
