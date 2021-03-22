//
//  LoginViewController.swift
//  fiin_swift
//
//  Created by admin on 3/8/21.
//

import UIKit
import IHKeyboardAvoiding
import Alamofire

class LoginViewController: UIViewController {
    // variable
    var data : LoginResponse?
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buttonShowPass: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputNumber: UITextField!
    @IBOutlet weak var buttonLoginView: UIButton!
    @IBOutlet weak var mainViewInput: UIView!
    @IBOutlet weak var buttonCreateAccountView: UIButton!
    let defaults = UserDefaults.standard
    var isShowPass : Bool = false
    
    // main
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCreateAccountView.layer.cornerRadius = 12
        mainViewInput.layer.cornerRadius = 12
        buttonLoginView.layer.cornerRadius = 8
        inputNumber.keyboardType = .phonePad
        inputPassword.isSecureTextEntry = true
        self.hideKeyboardWhenTappedAround()
        KeyboardAvoiding.avoidingView = self.containerView
        
    }
    
    // action
    @IBAction func onClickShowPass(_ sender: Any) {
        isShowPass = !isShowPass
        if isShowPass == true {
            if let image = UIImage(named: "eyeOutActive.png") {
                buttonShowPass.frame.size = CGSize(width: 24, height: 18)
                buttonShowPass.setImage(image, for: .normal)
                inputPassword.isSecureTextEntry = false
            }
        }else {
            if let image = UIImage(named: "EyeInactive@3x.png") {
                buttonShowPass.frame.size = CGSize(width: 24, height: 24)
                buttonShowPass.setImage(image, for: .normal)
                inputPassword.isSecureTextEntry = true
            }
        }
    }
        
    // alert
    func buildAlertNotice(title : String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK bạn nhớ", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    // action Login
    @IBAction func onLogin(_ sender: Any) {
//        if inputNumber.text == "" {
//            buildAlertNotice(title: "Nhập sđt vào đi bạn ơi ")
//        }
//        if inputPassword.text == "" {
//            buildAlertNotice(title: "Nhập mk bạn ơi")
//        }
//        dataAPI(phone: inputNumber.text!, pin: inputPassword.text!)
        dataAPI(phone: "0946621237", pin: "666666aB")
    }
}

// call api
extension LoginViewController {
    
    func dataAPI(phone : String,pin : String) {
        AuthenticationServices.login(
            phone: "0946621237",
            pin: "666666aB",
            success: {
                [weak self] (res) in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                            mainTabBarController.modalPresentationStyle = .fullScreen

                    self?.present(mainTabBarController, animated: true, completion: nil)
                    self!.defaults.set(res.data?.token,forKey: "token")
            }
            , failure: {
                [weak self] (message) in
                self!.buildAlertNotice(title: message)
            })
    }
}

// dismis keyboard
extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


