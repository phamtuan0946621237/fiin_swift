//
//  BorrowViewController.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import UIKit

class BorrowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var buttonBorrow: UIButton!
    @IBOutlet weak var iconNotice: UIImageView!
    @IBOutlet weak var titleNotice: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var heightNoticeView: NSLayoutConstraint!
    var data : [DataListBorrowResponse] = []
    var refreshControl : UIRefreshControl?
    var alert = UIAlertController()
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        _buildView() // set View
        addRefreshControl() // refresh List
        dataAPI(page : 1) // call API
        fetchInfoUser()// call API
        fetchInfoLimit()// call API
        openModal() // loading
        // action
        let onClickDocument = UITapGestureRecognizer(target: self, action:  #selector(self._onClickDocument))
        self.titleNotice.addGestureRecognizer(onClickDocument)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tutorial", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func _buildView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BorrowListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BorrowListTableViewCell")
        buttonBorrow.layer.cornerRadius = 12
        heightNoticeView.constant = 0
        amount.isHidden = true
        iconNotice.isHidden = true
    }
    // action
    @objc func addTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BorrowTutorialViewController") as? BorrowTutorialViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func _onClickDocument(sender : UITapGestureRecognizer) {
//        print("_onClickDocument")
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
    
    
}
// tableView
extension BorrowViewController {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BorrowDetailViewController") as? BorrowDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc!.idBorrow = self.data[indexPath.row].idList
    }
}
// call API
extension BorrowViewController {
    func dataAPI(page : Int) {
        BorrowServices.listBorrow(
            page: page,
            success: {
                [weak self] (res) in
//                self!.closeModal()
                self!.data.append(contentsOf: res.data!)
                self!.tableView.reloadData()
            }
            , failure: {
                [weak self] (message) in
//                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func fetchInfoUser() {
        InfoUserServices.infoUser(
            success: {
                [weak self] (res) in
//                self!.closeModal()
                if res.data?.activeEnterprise == true {
                    self!.heightNoticeView.constant = 0
                    self!.iconNotice.isHidden = true
                }else {
                    self!.iconNotice.isHidden = false
                    self!.heightNoticeView.constant = 74
                    self!.titleNotice.text = "Hoàn thiện hồ sơ giúp nâng cao hạn mức của bạn. Cập nhật ngay!"
                }
                
            }
            , failure: {
                [weak self] (message) in
//                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
    func fetchInfoLimit() {
        InfoLimitServices.infoLimit(
            success: {
                [weak self] (res) in
                self!.closeModal()
                if let wallet = res.data?.walletUser {
                    self!.amount.isHidden = false
                    self!.amount.text = String(Int(wallet[0].balance!)!.toAmount) + " VND"
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
extension BorrowViewController {
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
