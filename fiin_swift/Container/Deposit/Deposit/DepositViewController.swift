//
//  DepositViewController.swift
//  fiin_swift
//
//  Created by admin on 3/14/21.
//

import UIKit

class DepositViewController: UIViewController {

    @IBOutlet weak var chuyentienBKView: UIView!
    @IBOutlet weak var chuyentienliennganhangView: UIView!
    @IBOutlet weak var atmView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        _buildMainView() // buildMainView
        _handleView() // build Action
    }
    
    func _buildMainView() {
        atmView.layer.cornerRadius = 12
        chuyentienliennganhangView.layer.cornerRadius = 12
        chuyentienBKView.layer.cornerRadius = 12
    }
    
    func _handleView() {
        let _onClickDepositAtm = UITapGestureRecognizer(target: self, action:  #selector(self.onClickDepositAtm))
        self.atmView.addGestureRecognizer(_onClickDepositAtm)
    }

}

 // action
extension DepositViewController {
    @objc func onClickDepositAtm(sender : UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DepositTutorialViewController") as?
            DepositTutorialViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
