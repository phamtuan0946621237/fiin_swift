//
//  BorrowViewController.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import UIKit

class BorrowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var heightNoticeView: NSLayoutConstraint!
    var data : [DataListBorrowResponse] = []
    var refreshControl : UIRefreshControl?
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tutorial", style: .plain, target: self, action: #selector(addTapped))
        tableView.register(UINib(nibName: "BorrowListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BorrowListTableViewCell")
        
        dataAPI(page : 1)
        fetchInfoUser()
        fetchInfoLimit()
        addRefreshControl()
    }
    
    // action
    @objc func addTapped() {
        print("helloooo")
    }
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.black
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refreshList() {  
        self.data = []
        dataAPI(page: 1)
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.data != nil {
            return self.data.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BorrowListTableViewCell", for: indexPath) as! BorrowListTableViewCell
        let item = self.data[indexPath.row]
        cell.amount.text = String(item.amount!.toAmount) + " VND"
        cell.statusName.setTitle(item.statusName, for: .normal)
        cell.code.text = item.code
        cell.createdAt.text = item.createdAt
        cell.purposeName.text = item.purposeName
        return cell
    }
}
// call API
extension BorrowViewController {
    func dataAPI(page : Int) {
        BorrowServices.listBorrow(
            page: page,
            success: {
                [weak self] (res) in
                
                self!.data.append(contentsOf: res.data!)
                self!.tableView.reloadData()
            }
            , failure: {
                [weak self] (message) in
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func fetchInfoUser() {
        InfoUserServices.infoUser(
            success: {
                [weak self] (res) in
                print("res",res.data?.activeEnterprise)
                if res.data?.activeEnterprise == true {
                    self!.heightNoticeView.constant = 0
                }
            }
            , failure: {
                [weak self] (message) in
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func fetchInfoLimit() {
        InfoLimitServices.infoLimit(
            success: {
                [weak self] (res) in
                if let wallet = res.data?.walletUser {
                    self!.amount.text = String(Int(wallet[0].balance!)!.toAmount) + " VND"
                }
            }
            , failure: {
                [weak self] (message) in
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
}
