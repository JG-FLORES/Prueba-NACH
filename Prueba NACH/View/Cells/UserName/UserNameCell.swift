//
//  UserNameCell.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import UIKit

class UserNameCell: UITableViewCell, UITextFieldDelegate {
    
    var handlerString: ((String)->())?
    @IBOutlet weak var tfUserName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfUserName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.tfUserName {
            let text = textField.text ?? ""
            self.handlerString?(text)
            let allowedCharacter = CharacterSet.letters
            let allowedCharacterWhiteSpaces = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacter.isSuperset(of: characterSet) || allowedCharacterWhiteSpaces.isSuperset(of: characterSet)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfUserName {
            self.endEditing(true)
        }
        return true
    }
}
