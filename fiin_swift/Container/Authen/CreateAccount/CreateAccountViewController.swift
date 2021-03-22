//
//  CreateAccountViewController.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import UIKit

class CreateAccountViewController: UIViewController {
    // variale
    @IBOutlet weak var buttonCheckPassAgain: UIButton!
    @IBOutlet weak var buttonCheckPass: UIButton!
    @IBOutlet weak var inputPassAgain: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var inputPhone: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    var isShowPass : Bool = false
    var isShowPassAgain : Bool = false
    
    // main
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRegister.layer.cornerRadius = 8
        inputPhone.keyboardType = .numberPad
        hideKeyboardWhenTappedAround()
        if let image = UIImage(named: "eyeOutActive.png") {
            buttonCheckPass.setImage(image, for: .normal)
            inputPass.isSecureTextEntry = true
            buttonCheckPassAgain.setImage(image, for: .normal)
            inputPassAgain.isSecureTextEntry = true
        }
    }
    
    // action
    func buildAlertNotice(title : String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK bạn nhớ", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    @IBAction func onClickCheckPass(_ sender: Any) {
        isShowPass = !isShowPass
        switch isShowPass {
        case true:
            if let image = UIImage(named: "EyeInactive@3x.png") {
                buttonCheckPass.setImage(image, for: .normal)
                inputPass.isSecureTextEntry = false
            }
            break;
        case false :
            if let image = UIImage(named: "eyeOutActive.png") {
                buttonCheckPass.setImage(image, for: .normal)
                inputPass.isSecureTextEntry = true
            }
            break;
        default:
            break
        }
    }
    
    @IBAction func onClickCheckPassAgain(_ sender: Any) {
        isShowPassAgain = !isShowPassAgain
        switch isShowPassAgain {
        case true:
            if let image = UIImage(named: "EyeInactive@3x.png") {
                buttonCheckPassAgain.setImage(image, for: .normal)
                inputPassAgain.isSecureTextEntry = false
            }
            break;
        case false :
            if let image = UIImage(named: "eyeOutActive.png") {
                buttonCheckPassAgain.setImage(image, for: .normal)
                inputPassAgain.isSecureTextEntry = true
            }
            break;
        default:
            break
        }
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        if inputPhone.text == "" {
            buildAlertNotice(title : "Nhập sđt vào bạn ơi!")
        }
        if inputPass.text == "" {
            buildAlertNotice(title : "Nhập Mật khẩu vào bạn ơi!")
        }
        if inputPassAgain.text == "" {
            buildAlertNotice(title : "Nhập lại MK đi bạn ơi")
        }
        
    }
}

// dismis keyboard
extension CreateAccountViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

