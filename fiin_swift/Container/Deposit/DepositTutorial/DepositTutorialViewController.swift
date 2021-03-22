//
//  DepositTutorialViewController.swift
//  fiin_swift
//
//  Created by admin on 3/14/21.
//

import UIKit
import SDWebImage
class DepositTutorialViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exampleView: UIView!
    @IBOutlet weak var exampleLabel: UILabel!
    var bankInfoResponse : [BankInfoDataResponse]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBankInfo()
        fetchUserData()
        exampleView.layer.cornerRadius = 4
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchBankInfo () {
        BankInfoServices.bankInfo(
            success: {
                [weak self] (res) in
                self!.bankInfoResponse = res
                self?.collectionView.reloadData()
            }
            , failure: {
                [weak self] (message) in
                print("error")
            })
    }
    
                
    func fetchUserData() {
        let service = Connect()
        service.fetchPost(param : nil,endUrl : ConstAPI().userData)
        service.completionHandler {
            [weak self] (res) in
            if let response = res as? [String : Any] {
                if let status  = response["status"] as? String {
                    switch status {
                    case "success":
                        if let data = response["data"] as? [String : Any] {
                            if let phone = data["phone"] as? String {
                                self!.exampleLabel.text = "Ví dụ : Fiin \(phone)"
                            }
                        }
                        break;
                    case "error":
                        break;
                    default:
                        break;
                    }
            }
        }
    }
}
    
}

extension DepositTutorialViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankInfoResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBankInfoCollectionViewCell", for: indexPath) as! ListBankInfoCollectionViewCell
        let item = bankInfoResponse[indexPath.row]
        cell.name.text = item.account_holder
        cell.branch.text = item.branch
        cell.stk.text = item.urlImage
        cell.nameBank.text = item.name
        cell.icon.sd_setImage(with: URL(string: item.urlImage!), completed: nil)
//        let mainColor : UIColor = UIColor(red: 66/255, green: 83/255, blue: 161/255, alpha: 1.0)
        cell.viewLayout.layer.borderWidth = 1
        cell.viewLayout.layer.borderColor = UIColor.main.cgColor
        return cell
    }
}
