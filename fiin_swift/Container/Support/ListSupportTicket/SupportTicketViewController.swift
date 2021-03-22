//
//  SupportTicketViewController.swift
//  fiin_swift
//
//  Created by admin on 3/10/21.
//

import UIKit
import Alamofire
class SupportTicketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var data : ListSupportResponse?
    let defaults = UserDefaults.standard
    @IBOutlet weak var buttonSendSupportView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource  = self
        
        tableView.register(UINib(nibName: "ListSupportTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListSupportTableViewCell")
        buttonSendSupportView.layer.cornerRadius = 12
        let parram : [String : Any] = ["page" : 1]
        callListSupport(parram : parram)
    }
    func buildAlertNotice(title : String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK bạn nhớ", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }

    @IBAction func onClickSendSupport(_ sender: Any) {
        
    }
}
extension SupportTicketViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.data?.data != nil {
            return (self.data?.data!.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListSupportTableViewCell", for: indexPath) as! ListSupportTableViewCell
        let item = self.data?.data![indexPath.row]
        cell.titleSupport.text = item?.description
        cell.timeSupport.text = item?.date
        cell.statusSupport.layer.cornerRadius = 12
        if item?.status == "cho_xu_ly" {
            cell.statusSupport.text = "Chờ xử lý"
            cell.statusSupport.backgroundColor = UIColor(red: 244/255, green: 164/255, blue: 37/255, alpha: 1.0)
        }else {
            cell.statusSupport.text = "Đã xử lý"
            cell.statusSupport.backgroundColor = UIColor(red: 63/255, green: 130/255, blue: 254/255, alpha: 1.0)
        }
        return cell
    }
}
extension SupportTicketViewController {
    func callListSupport(parram : [String : Any]) {
        let service = Connect()
        service.fetchGet(parram : parram,endUrl : ConstAPI().listSupportTicket)
        service.completionHandler {
            [weak self] (res) in
            if let response = res as? [String : Any] {
                let dataRes = ListSupportResponse()
                dataRes.status = response["status"] as? String
                dataRes.code = response["code"] as? String
                dataRes.message = response["message"] as? String
                var resData : [ListSupportDataResponse] = []
                if let dataItem = response["data"] as? [[String : Any]] {
                    for dataObj in dataItem {
                        let dataResponse = ListSupportDataResponse()
                        dataResponse.date = dataObj["date"] as? String
                        dataResponse.status = dataObj["status"] as? String
                        dataResponse.description = dataObj["description"] as? String
                        resData.append(dataResponse)
                    }
                    dataRes.data = resData
                }
                switch dataRes.status {
                case "success":
                    self!.data = dataRes
                    self!.tableView.reloadData()
                    break;
                case "error":
                    self!.buildAlertNotice(title: dataRes.message!)
                    break;
                default:
                    break;
                }
            }
        }
    }
    
}
