//
//  WithdrawCreateViewController.swift
//  fiin_swift
//
//  Created by admin on 4/12/21.
//

import UIKit

class WithdrawCreateViewController: UIViewController {
    var alert = UIAlertController()
    @IBOutlet weak var notice: UILabel!
    @IBOutlet weak var moneyInput: UITextField!
    @IBOutlet weak var buttonWithdraw: UIButton!
    @IBOutlet weak var numberCard: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var bank: UILabel!
    @IBOutlet weak var numberAccout: UILabel!
    @IBOutlet weak var branch: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var inputMoneyWithdrawView: UIView!
    
//    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        inputMoneyWithdrawView.layer.cornerRadius = 6
        buttonWithdraw.layer.cornerRadius = 12
        hideKeyboardWhenTappedAround()
        moneyInput.keyboardType = .numberPad
        self.dataAPI()
    }
    @IBAction func onClickWithdraw(_ sender: Any) {
        if moneyInput.text == "" {
            self.alertNoticeEnterMoney()
        }else {
            openModal()
            WithdrawServices.withdrawRequest(
                amount : moneyInput.text!,
                pin : "Ptuan123",
                success: {
                    [weak self] (res) in
                    self!.closeModal()
                    print("resaaaaaaa",res.status)
                    print("resaaaaaaa",res.data?.transaction_code)
                    self!.buildAlertNotice(title: res.message!, message: res.data!.message_withdrawal)
                }
                , failure: {
                    [weak self] (message) in
                    self!.closeModal()
                    let extensionView = ViewExtension()
                    extensionView.buildAlertNotice(title: message)
                })
        }
        
    }
}

extension WithdrawCreateViewController {
    func dataAPI() {
        WithdrawServices.withdrawInfo(
            type : "rut",
            success: {
                [weak self] (res) in
                print("resaaaaaaa",res.data?.user_receive_name)
                if let data = res.data {
                    self!.numberCard.text = data.card_number
                    self!.fee.text = String(Int(data.withdraw_fee!)!.toAmount) + " VND"
                    self!.name.text = data.user_receive_name
                    self!.numberAccout.text = data.acc_bank
                    self!.bank.text = data.bank_name
                    self!.branch.text = data.bank_branch
                    self!.notice.text = data.description
                    
                }
            }
            , failure: {
                [weak self] (message) in
//                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    
}

// extension
extension WithdrawCreateViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func buildAlertNotice(title : String,message : String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { [self] action in
            print("ưnlgk;mr")
//            fetchBorrowConfirm(purposeCode: purposeCode, amount: amount, duration: duration)
        }))
//        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    func alertNoticeEnterMoney() {
        let alert = UIAlertController(title: "Nhập số tiền đi bạn ơi ", message: nil, preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { [self] action in
            print("ưnlgk;mr")
//            fetchBorrowConfirm(purposeCode: purposeCode, amount: amount, duration: duration)
        }))
//        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
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
