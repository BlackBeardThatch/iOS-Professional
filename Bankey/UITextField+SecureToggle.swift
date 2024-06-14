//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Jason Hung on 2024/6/13.
//

import UIKit

let passworldToggleButton = UIButton(type: .custom)

extension UITextField {
    func enablePasswordToggle() {
        passworldToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passworldToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passworldToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passworldToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        passworldToggleButton.isSelected.toggle()
    }
}
