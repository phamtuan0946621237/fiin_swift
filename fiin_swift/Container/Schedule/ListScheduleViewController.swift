//
//  ListScheduleViewController.swift
//  fiin_swift
//
//  Created by admin on 4/15/21.
//

import UIKit

class ListScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var alert = UIAlertController()
    var dataBorrowContract : [DataBorrowContractResponse] = []
    var dataLenddingContract : [DataLeddingContractResponse] = []
    var segmentIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListScheduleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListScheduleTableViewCell")
        openModal()
        dataBorrowContractAPI(page: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onChangeSegment(_ sender: UISegmentedControl) {
        openModal()
        if sender.selectedSegmentIndex == 0 {
            segmentIndex = 0
            dataBorrowContractAPI(page: 1)
        }else {
            segmentIndex = 1
            dataLeddingContractAPI(page: 1)
        }
    }
}
extension ListScheduleViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segmentIndex == 0 {
            return dataBorrowContract.count
        }else {
            return dataLenddingContract.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListScheduleTableViewCell", for: indexPath) as! ListScheduleTableViewCell
        if self.segmentIndex == 0 {
            let item = dataBorrowContract[indexPath.row]
            cell.status.text = item.statusName
            cell.period.text = item.periodName
            cell.time.text = item.timeStatusName
            cell.hopdong.text = item.ContractCode
            cell.money.text = String(item.debtAmount!)
            cell.name.text = item.purposeName
        }else {
            let item = dataLenddingContract[indexPath.row]
            cell.status.text = item.statusName
            cell.period.text = item.periodName
            cell.time.text = item.timeStatusName
            cell.hopdong.text = item.lendingContractCode
            cell.money.text = String(item.amount!)
            cell.name.text = item.borrowerName
        }
        return cell
    }
}

extension ListScheduleViewController {
    func dataBorrowContractAPI(page : Int) {
        
        ScheduleServices.listBorrowContract(
            page : page,
            success: {
                [weak self] (res) in
                self!.closeModal()
                switch res.status {
                case "success":
                    self?.dataBorrowContract = res.data!
                    self!.tableView.reloadData()
                    break;
                case "error" :
                    break;
                default :
                    break;
                }
                
            }
            , failure: {
                [weak self] (message) in
//                self!.closeModal()
                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func dataLeddingContractAPI(page : Int) {
        ScheduleServices.listLenddingContract(
            page : page,
            success: {
                [weak self] (res) in
                self!.closeModal()
                switch res.status {
                case "success":
                    self?.dataLenddingContract = res.data!
                    self!.tableView.reloadData()
                    break;
                case "error" :
                    
                    break;
                default :
                    break;
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

// extension
extension ListScheduleViewController {
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
