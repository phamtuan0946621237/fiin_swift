//
//  WithdrawViewController.swift
//  fiin_swift
//
//  Created by admin on 3/30/21.
//

import UIKit

class WithdrawViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var selectedTimeView: UIView!
    var alert = UIAlertController()
    var data : [DataWithdrawResponse] = []
    @IBOutlet weak var buttonWithdrawView: UIButton!
    @IBOutlet weak var inputTime: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dataAPI(month: "03-2020", page: 1)
        
    }
    
    @objc func datePickerDone() {
        inputTime.resignFirstResponder()
       }

       @objc func dateChanged() {
        inputTime.text = "\(datePicker.date)"
       }
    
    func setupView() {
        inputTime.text = "06/2020"
        buttonWithdrawView.layer.cornerRadius = 12
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListWithdrawItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListWithdrawItemTableViewCell")
    }
    
    @IBAction func onClickPickTIme(_ sender: Any) {
        datePicker = UIDatePicker.init(frame:  CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
               datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        inputTime.inputView = datePicker
               let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
               let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        inputTime.inputAccessoryView = toolBar
    }
    
    
    
}
extension WithdrawViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListWithdrawItemTableViewCell", for: indexPath) as! ListWithdrawItemTableViewCell
        let item = self.data[indexPath.row]
//        cell.amount.text = String(item.transaction_amount!)
        cell.name.text = item.bank_name
        cell.numberAccount.text = item.acc_bank
        cell.status.text = item.status
        cell.time.text = item.transaction_date
        return cell
    }
}
extension WithdrawViewController {
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


extension WithdrawViewController {
    func dataAPI(month : String,page : Int) {
        WithdrawServices.listWithdraw(
            month: month,
            page : page,
            success: {
                [weak self] (res) in
                print("resaaaaaaa",res.status)
                print("transaction_amount",res.data![0].transaction_amount)
                if let daataa = res.data {
                    self!.data = daataa
                }
                
                self!.tableView.reloadData()
            }
            , failure: {
                [weak self] (message) in
//                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
}
