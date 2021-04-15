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
    var alert = UIAlertController()
    
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
//        self.window = [[UIWindow, alloc], initWithFrame:[UIScreen mainScreen].bounds];
        
//        LoadingOverlay.shared.showOverlay(view: self.view)
        openModal()
//        LoadingViewController.showAlert()
        dataAPI(phone: "0965403820", pin: "999999")
        // 0946621237 - Ptuan123
    }
    
}

// loading
extension LoginViewController {
    func openModal() {
       print("button fire")
       self.alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
       alert.view.tintColor = UIColor.black
       let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
       loadingIndicator.hidesWhenStopped = true
       loadingIndicator.style = UIActivityIndicatorView.Style.gray
       loadingIndicator.startAnimating();
       alert.view.addSubview(loadingIndicator)
       self.present(alert, animated: true)
   }
    func closeModal() {
       alert.dismiss(animated: true, completion: nil)
   }
}

// call api
extension LoginViewController {
    func dataAPI(phone : String,pin : String) {
        AuthenticationServices.login(
            phone: phone,
            pin: pin,
            success: {
                [weak self] (res) in
                self!.closeModal()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                            mainTabBarController.modalPresentationStyle = .fullScreen

                    self?.present(mainTabBarController, animated: true, completion: nil)
                    self!.defaults.set(res.data?.token,forKey: "token")
            }
            , failure: {
                [weak self] (message) in
                self!.closeModal()
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

