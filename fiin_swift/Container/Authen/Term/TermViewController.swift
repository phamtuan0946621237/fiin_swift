//
//  TermViewController.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import UIKit

class TermViewController: UIViewController {

    @IBOutlet weak var checkerView: UIButton!
    @IBOutlet weak var buttonAccept: UIButton!
    var isShow : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAccept.layer.cornerRadius = 4
        checkerView.backgroundColor = .white
        checkerView.layer.borderWidth = 1
        checkerView.layer.masksToBounds = true
        checkerView.layer.borderColor = UIColor.main.cgColor
        buttonAccept.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        buttonAccept.isEnabled = false
    }
    
    @IBAction func onClickChecker(_ sender: Any) {
        isShow = !isShow
        if isShow == false {
            buttonAccept.isEnabled = false
            checkerView.backgroundColor = .white
            buttonAccept.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        }else {
            checkerView.backgroundColor = UIColor.main
            buttonAccept.backgroundColor = UIColor.main
            buttonAccept.isEnabled = true
        }
    }
    
    @IBAction func onClckAccept(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as?
            CreateAccountViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
