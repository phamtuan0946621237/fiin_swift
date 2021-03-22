//
//  CreateSupportTicketViewController.swift
//  fiin_swift
//
//  Created by admin on 3/11/21.
//

import UIKit

class CreateSupportTicketViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerTypeSupport: UITextField!
    let dataTypeSupport = ["indo","VietNam","USA","UK"]
    var pickerView = UIPickerView()
    var transparentView = UIView()
//    @IBOutlet weak var pickerView: UIView!
    var supportView = UIView()
    
    @IBOutlet weak var typePickerView: UIView!
    

    var heightModal : CGFloat = 220
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onClickTypeSupport = UITapGestureRecognizer(target: self, action:  #selector(self._onClickTypeSupport))
        typePickerView.addGestureRecognizer(onClickTypeSupport)
        
        pickerView.dataSource = self
        pickerView.dataSource = self
//        pickerTypeSupport.inputView = pickerView
        
    }
}

extension CreateSupportTicketViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataTypeSupport.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataTypeSupport[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTypeSupport.text = dataTypeSupport[row]
        pickerTypeSupport.resignFirstResponder()
    }
}
extension CreateSupportTicketViewController {
@objc func _onClickTypeSupport() {

    //modal
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height + 88)
        window?.addSubview(transparentView)
        let screenSize = UIScreen.main.bounds.size
        supportView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.heightModal)
        supportView.backgroundColor = .white
        window?.addSubview(supportView)
        transparentView.alpha  = 0.5
        let tapGesrure = UITapGestureRecognizer(target: self, action: #selector(_closeModalSupportTicket))
        transparentView.addGestureRecognizer(tapGesrure)
        transparentView.alpha = 0
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.supportView.frame = CGRect(x: 0, y: screenSize.height - self.heightModal, width: screenSize.width, height: self.heightModal)
        }, completion: nil)

    supportView.addSubview(pickerView)
    pickerView.frame.size = CGSize(width: self.view.bounds.width, height: self.heightModal)
    
    
}
@objc func _closeModalSupportTicket(){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
            self.supportView.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: self.heightModal)

        }, completion: nil)
}
}
