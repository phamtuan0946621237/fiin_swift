//
//  BorowConfirmViewController.swift
//  fiin_swift
//
//  Created by admin on 3/26/21.
//

import UIKit

class BorowConfirmViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // variable
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var purposeCode : String?
    var duration : String?
    var alert = UIAlertController()
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var heightReceiverView: NSLayoutConstraint!
    var amount: String?
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var amountString: UILabel!
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    @IBOutlet weak var purposeName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var describle: UILabel!
    @IBOutlet weak var receiver: UILabel!
    @IBOutlet weak var reduceFee: UILabel!
    @IBOutlet weak var originalFee: UILabel!
    @IBOutlet weak var typeContract: UILabel!
    @IBOutlet weak var originalInterst: UILabel!
    @IBOutlet weak var reduceInterest: UILabel!
    @IBOutlet weak var timeEndBorrow: UILabel!
    @IBOutlet weak var timeStartBorrow: UILabel!
    @IBOutlet weak var heightDescribleView: NSLayoutConstraint!
    var isShowDescrible : Bool = false
    var data : DataBorrowingContractConfirmResponse?
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        openModal() // loading
        fetchBorrowContractConfirm(purposeCode: purposeCode!, amount: amount!, duration: duration!) // call API
        setInitialView() // set view
        
    }
    func setInitialView() {
        heightLayout.constant = 1500
        heightDescribleView.constant = 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListBorrowProcessItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListBorrowProcessItemTableViewCell")
        buttonConfirm.layer.cornerRadius = 12
    }
    
    // action
    @IBAction func onClickConfirm(_ sender: Any) {
        buildAlertNotice(purposeCode: self.purposeCode!, amount: self.amount!, duration: self.duration!)
    }
    
    
    
    @IBAction func onClickShowDescrible(_ sender: Any) {
        isShowDescrible = !isShowDescrible
        if (isShowDescrible == false) {
            heightDescribleView.constant = 0
        }else {
            heightDescribleView.constant = 64
        }
    }
    
}

extension BorowConfirmViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = self.data {
            if let repayment = self.data!.repayment {
                return repayment.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListBorrowProcessItemTableViewCell", for: indexPath) as! ListBorrowProcessItemTableViewCell
        return cell
    }
}
extension BorowConfirmViewController {
    func fetchBorrowConfirm(purposeCode : String,amount : String,duration : String) {
        BorrowServices.borrowConfirm(
            purposeCode: purposeCode,
            amount: amount,
            duration: duration,
            success: {
                [weak self] (res) in
                let alert = UIAlertController(title: "Vay tiền Thành công ", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Rút tiền đi", style: .default, handler: { [self] action in

                }))
                alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))
                self!.present(alert, animated: true)
            }
            , failure: {
                [weak self] (message) in
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func fetchBorrowContractConfirm(purposeCode : String,amount : String,duration : String) {
        BorrowServices.borrowContractConfirm(
            purposeCode: purposeCode,
            amount: amount,
            duration: duration,
            success: {
                [weak self] (res) in
                self!.closeModal()
                self!.data = res.data
                let item = res.data
                self!.money.text = String((item?.debtAmount?.toAmount)!) + " VND"
                self!.amountString.text = "(Mười lăm triệu đồng)"
                self!.purposeName.text = item?.purposeName
                self!.time.text = String((item?.duration)!)
                self!.receiver.text = item?.userBorrowName
                self!.describle.text = "Lorem ipsum is placeholder text commonly used in the graphic, print,..."
                self!.reduceFee.text = String((item?.reduceFeeAmount?.toAmount)!) + " VND"
                self!.originalFee.text = String((item?.feeAmount?.toAmount)!) + " VND"
                self!.typeContract.text = item?.contractTypeName
                self!.originalInterst.text = String((item?.interestAmount?.toAmount)!) + " VND"
                self!.reduceInterest.text = String((item?.reduceInterestAmount?.toAmount)!) + " VND"
                self!.timeEndBorrow.text = item?.endDate
                self!.timeStartBorrow.text = item?.startDate
                self!.interest.text = String((item?.interestRate)!) + "%" + "/ năm"
                if item?.reduceInterestAmount == 0 {
                    self!.reduceFee.isHidden = true
                }
                if item?.reduceFeeAmount == 0 {
                    self!.reduceInterest.isHidden = true
                }
                if self?.purposeCode == "vay_tien_mat_tra_gop" {
                    self!.heightReceiverView.constant = 0
                    self!.heightTableView.constant = CGFloat(142 * ((res.data?.repayment!.count)! - 1))
                    self?.heightLayout.constant = 844 + CGFloat(142 * ((res.data?.repayment!.count)! - 1))
                }else {
                    self!.heightTableView.constant = 0
                    self?.heightLayout.constant = 844
                }
                
                self!.tableView.reloadData()
            }
            , failure: {
                [weak self] (message) in
                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
}

// modal alert
extension BorowConfirmViewController {
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
    
    func buildAlertNotice(purposeCode : String,amount : String,duration : String) {
        let alert = UIAlertController(title: "Vay tiền đi bạn ơi ", message: nil, preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { [self] action in
            print("ưnlgk;mr")
            fetchBorrowConfirm(purposeCode: purposeCode, amount: amount, duration: duration)
            
        }))
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
