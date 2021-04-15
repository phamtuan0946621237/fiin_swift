//
//  BorrowDetailViewController.swift
//  fiin_swift
//
//  Created by admin on 3/29/21.
//

import UIKit

class BorrowDetailViewController: UIViewController {
    var idBorrow : Int?
    var alert = UIAlertController()
    @IBOutlet var layout: UIView!
    @IBOutlet weak var totalBorrow: UILabel!
    @IBOutlet weak var totalPay: UILabel!
    @IBOutlet weak var totalPayVIew: UIView!
    @IBOutlet weak var headerView: UIStackView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var purposeName: UILabel!
    @IBOutlet weak var originFee: UILabel!
    @IBOutlet weak var reduceFee: UILabel!
    @IBOutlet weak var typeContract: UILabel!
    @IBOutlet weak var originInterest: UILabel!
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var timeBorrow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openModal()
        fetchBorrowDetail(id : self.idBorrow!)
        _buildView()
        
//        totalPayVIew.
    }
    func _buildView() {
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.graybackground.cgColor
        status.layer.cornerRadius = 8
        totalPayVIew.layer.addBorder(edge: UIRectEdge.left, thickness: 1)
        totalBorrow.isHidden = true
        totalPay.isHidden = true
        status.isHidden = true
        purposeName.isHidden = true
        originFee.isHidden = true
        reduceFee.isHidden = true
        typeContract.isHidden = true
        originInterest.isHidden = true
        interest.isHidden = true
        code.isHidden = true
        startDate.isHidden = true
        timeBorrow.isHidden = true
        endDate.isHidden = true
        
    }

}

extension BorrowDetailViewController {
    func fetchBorrowDetail(id : Int) {
        BorrowServices.borrowDetail(
            id : id ,
            success: {
                [weak self] (res) in
                self!.closeModal()
                if let data = res.data {
                    // show screen
                    self!.totalBorrow.isHidden = false
                    self!.totalPay.isHidden = false
                    self!.status.isHidden = false
                    self!.purposeName.isHidden = false
                    self!.reduceFee.isHidden = false
                    self!.typeContract.isHidden = false
                    self!.interest.isHidden = false
                    self!.code.isHidden = false
                    self!.startDate.isHidden = false
                    self!.timeBorrow.isHidden = false
                    self!.endDate.isHidden = false
                    // fill data
                    self?.totalPay.text = String((data.debtAmount?.toAmount)!) + " VND"
                    self?.totalBorrow.text = String((data.borrowAmount?.toAmount)!) + " VND"
                    self?.purposeName.text = data.purposeName
                    self?.code.text = data.code
                    self?.timeBorrow.text = String(data.duration!)
                    self?.startDate.text = data.startDate
                    self?.endDate.text = data.endDate
                    self?.interest.text = String((data.interestAmount?.toAmount)!) + " VND"
                    self?.typeContract.text = data.contractTypeName
                    self?.reduceFee.text = String(data.feeAmount!.toAmount) + " VND"
                }
                
            }
            , failure: {
                [weak self] (message) in
                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
}

extension BorrowDetailViewController {
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
