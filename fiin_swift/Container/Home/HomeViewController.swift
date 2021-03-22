//
//  HomeViewController.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import UIKit
import IHKeyboardAvoiding
import Alamofire
struct Banner {
    var title : String
}
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let defaults = UserDefaults.standard
    var transparentView = UIView()
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var layoutFeature: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lendView: UIView!
    @IBOutlet weak var depositView: UIView!
    @IBOutlet weak var withdraw: UIView!
    @IBOutlet weak var borrowView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var heightModal : CGFloat = 412
    @IBOutlet weak var featureView1: UIView!
    @IBOutlet weak var featureView2: UIView!
    @IBOutlet weak var featureView3: UIView!
    @IBOutlet weak var featureView4: UIView!
    @IBOutlet weak var featureView5: UIView!
    @IBOutlet weak var featureView6: UIView!
    @IBOutlet weak var featureView7: UIView!
    @IBOutlet weak var featureView8: UIView!
    
    @IBOutlet weak var depositFeature: UIView!
    var supportView = UIView()
    //    @IBOutlet weak var bannerContainerView: UIView!
    var data = [
        Banner(title: "banner.jpg"),
        Banner(title: "banner2.png"),
        Banner(title: "banner3.jpg")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = self.defaults.string(forKey: "token")
        print("token : ",token!)
        _buildMainView()
        callAPIUserInfo()
    }
    // view
    func _buildMainView() {
        borrowView.layer.cornerRadius = 12
        depositView.layer.cornerRadius = 12
        withdraw.layer.cornerRadius = 12
        lendView.layer.cornerRadius = 12
        collectionView.showsHorizontalScrollIndicator = false
        featureView1.layer.cornerRadius = 16
        featureView2.layer.cornerRadius = 16
        featureView3.layer.cornerRadius = 16
        featureView4.layer.cornerRadius = 16
        featureView5.layer.cornerRadius = 16
        featureView6.layer.cornerRadius = 16
        featureView7.layer.cornerRadius = 16
        featureView8.layer.cornerRadius = 16
        backgroundView.clipsToBounds = true
        layoutFeature.layer.cornerRadius = 12
        backgroundView.layer.cornerRadius = 24
        backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let onClickSupport = UITapGestureRecognizer(target: self, action:  #selector(self.onClickSupportTicket))
        self.featureView6.addGestureRecognizer(onClickSupport)
        
        let onClickDeposit = UITapGestureRecognizer(target: self, action:  #selector(self.onClickDeposit))
        self.depositFeature.addGestureRecognizer(onClickDeposit)
        
        let onClickBorrow = UITapGestureRecognizer(target: self, action:  #selector(self.onClickBorrow))
        self.borrowView.addGestureRecognizer(onClickBorrow)
        
    }
    @objc func onClickBorrow(sender : UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BorrowViewController") as?
            BorrowViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func onClickDeposit(sender : UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DepositViewController") as?
            DepositViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func onClickSupportTicket(sender : UITapGestureRecognizer) {
        let modalSupportTicket = ModalSupportTicket()
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height + 88)
        window?.addSubview(transparentView)
        let screenSize = UIScreen.main.bounds.size
        supportView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.heightModal)
        supportView.backgroundColor = .blue
        modalSupportTicket.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: self.heightModal)
        
        supportView.addSubview(modalSupportTicket)
        window?.addSubview(supportView)
        transparentView.alpha  = 0.5
        let tapGesrure = UITapGestureRecognizer(target: self, action: #selector(onClickOpenModalSupport))
        transparentView.addGestureRecognizer(tapGesrure)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.supportView.frame = CGRect(x: 0, y: screenSize.height - self.heightModal, width: screenSize.width, height: self.heightModal)
        }, completion: nil)
        
        
        // call action sendSupport
        let onClickListSupport = UITapGestureRecognizer(target: self, action:  #selector(self._onClickListSupport))
        modalSupportTicket.sendSupportView.addGestureRecognizer(onClickListSupport)
    }
    
    // action
    
    @objc func _onClickListSupport() {
        _closeModalSupportTicket()
        let vc = storyboard?.instantiateViewController(withIdentifier: "SupportTicketViewController") as?
            SupportTicketViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func onClickOpenModalSupport() {
        _closeModalSupportTicket()
    }
    
    func _closeModalSupportTicket(){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
            self.supportView.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: self.heightModal)
            
        }, completion: nil)
    }
    
    @IBAction func onClickNotification(_ sender: Any) {
        print("notification")
    }
    @IBAction func onClickSupportTicket(_ sender: Any) {
        print("support ticket")
    }
    
    @IBAction func onClickBalance(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BalanceViewController") as?
            BalanceViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
// collection View
extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerHomeCollectionViewCell", for: indexPath) as! BannerHomeCollectionViewCell
        cell.banner.image = UIImage(named: data[indexPath.row].title)
        cell.banner.layer.cornerRadius = 16
        return cell
    }
}

extension HomeViewController {
    func callAPIUserInfo() {
        let service = Connect()
        service.fetchPost(param : nil,endUrl : "user/get-data")
        service.completionHandler {
            [weak self] (res) in
            if let response = res as? [String : Any] {
                print("res",response)
            }
        }
    }
    
}

