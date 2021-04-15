//
//  BorrowCreateViewController.swift
//  fiin_swift
//
//  Created by admin on 3/23/21.
//

import UIKit
struct StateBorrow {
    var type : String
    var amount : String
    var time : String
}
let initialState = StateBorrow(type: "vay_tien_mat", amount: "1000000", time: "10")

class BorrowCreateViewController: UIViewController {
    // variable
    var alert = UIAlertController()
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var citiesField: UITextField!
    @IBOutlet weak var MoneyTextField: UITextField!
    var data : [DataBorrowOptionResponse] = []
    var selectedIndex : Int = 0
    var selectedTimeIndex : Int = 0
    var contentModal = UIView()
    var transparentView = UIView()
    var heightModal : CGFloat = 270
    var pickerView = UIPickerView()
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCountry: String?
    @IBOutlet weak var collectionTimeView: UICollectionView!
    var valueChangeMoney : String? = ""
    var state = initialState
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        openModal() // loading
        citiesField.isEnabled = false
        citiesField.isUserInteractionEnabled = false
        buttonSend.layer.cornerRadius = 12
        setupPicker()
        setupTimeCollection()
        fetchBorrowOption()
        setupTypeBorrow()
    }
    // action

    @objc func _onClickSelectedMoney() {
        citiesField.text = valueChangeMoney == "" ? String(data[selectedIndex].amountOption![0].toAmount) + " VND" : valueChangeMoney
        _closeModalSupportTicket()
    }
    
    @IBAction func onClickSendBorrow(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BorowConfirmViewController") as? BorowConfirmViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc!.purposeCode = state.type
        vc!.amount = state.amount
        vc!.duration = state.time
        
    }
}

// delegate collectionView
extension BorrowCreateViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTimeIndex = 0
        self.collectionView.reloadData()
        self.collectionTimeView.reloadData()
        
        switch collectionView  {
        case self.collectionView:
            selectedIndex = indexPath.row
            state.type = data[selectedIndex].key!
            state.amount = String(data[selectedIndex].amountOption![0])
            state.time = String(data[selectedIndex].durationOption![0])
            self.citiesField.text = String(self.data[self.selectedIndex].amountOption![0].toAmount) + " VND"
            break;
        case self.collectionTimeView:
            selectedTimeIndex = indexPath.row
            state.time = String(data[selectedIndex].durationOption![indexPath.row])
            break;
        default :
            break;
        }
        
        
    }
}
extension BorrowCreateViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[selectedIndex].amountOption!.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(data[selectedIndex].amountOption![row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueChangeMoney = String(data[selectedIndex].amountOption![row].toAmount) + " VND"
        state.amount = String(data[selectedIndex].amountOption![row])
    }
}

 // main view
extension BorrowCreateViewController {
    func setupTimeCollection() {
        collectionTimeView.dataSource = self
        collectionTimeView.delegate = self
        collectionTimeView.showsHorizontalScrollIndicator = false
    }
    
    func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func setupTypeBorrow () {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
        }
}

// setUpPicker

// call API
extension BorrowCreateViewController {
    
    func fetchBorrowOption() {
        BorrowServices.borrowOption(
            success: {
                [weak self] (res) in
                self!.closeModal()
                    self!.data = res.data!
                    self!.citiesField.text = String(self!.data[self!.selectedIndex].amountOption![0].toAmount) + " VND"
                    self!.collectionView.reloadData()
                    self!.collectionTimeView.reloadData()
            }
            , failure: {
                [weak self] (message) in
                self!.closeModal()
                let extensionView = ViewExtension()
                extensionView.buildAlertNotice(title: message)
            })
    }
}


// dataSource Collection
extension BorrowCreateViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeBorrowCollectionViewCell", for: indexPath) as!
                TypeBorrowCollectionViewCell
            let item = self.data[indexPath.row]
            cell.titleBorrow.text = item.value

            cell.checkBorrow.image = self.selectedIndex == indexPath.row  ? UIImage(named: "check_success.png") : UIImage(named: "Uncheck.png")
            cell.titleBorrow.textColor = self.selectedIndex == indexPath.row ? UIColor.black : UIColor.grayText
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeBorrowCollectionViewCell", for: indexPath) as!
                TimeBorrowCollectionViewCell
            cell.contentTimeView.backgroundColor = selectedTimeIndex == indexPath.row ? UIColor.orangeColor : UIColor.graybackground
            cell.contentTimeView.layer.cornerRadius = 4
            cell.dateBorrow.textColor = selectedTimeIndex == indexPath.row ? .white : .black
            cell.month.textColor = selectedTimeIndex == indexPath.row ? .white : .black
            let item = data[selectedIndex].durationOption![indexPath.row]
            switch data[selectedIndex].key  {
            case "vay_tien_mat":
                cell.month.text = String(data[selectedIndex].durationOption![indexPath.row])
                cell.dateBorrow.text = data[selectedIndex].dataUnitTypeOption?.unitName
                break;
            case "vay_tien_mat_tra_gop":
                cell.month.text = String(item) + String((data[selectedIndex].dataUnitTypeOption?.unitName)!)
                cell.dateBorrow.text = String(item * 30) + "Ngày"
                break;
            default :
                break;
            }
            return cell
        }
        
    }
    
    // number CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.data.count <= 0 {
            return 0
        }
        switch collectionView  {
        case self.collectionView:
                return self.data.count
        case self.collectionTimeView:
                return self.data[selectedIndex].durationOption!.count
        default :
            return 0
        }
    }
}
// setup modal
extension BorrowCreateViewController {
    // close Modal
    @objc func _closeModalSupportTicket(){
            let screenSize = UIScreen.main.bounds.size
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0
                self.contentModal.frame = CGRect(x: 0, y: screenSize.height , width: screenSize.width, height: self.heightModal)
            }, completion: nil)
    }
    // open Modal
    @IBAction func onClickSelectedMoney(_ sender: Any) {
        // setupModal
        setupViewModal()
        //setup View Modal
        let viewSelected = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        let buttonSelected = UIButton(frame: CGRect(x: 16, y: 16, width: 50, height: 18))
        buttonSelected.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        buttonSelected.setTitle("Chọn", for: .normal)
        buttonSelected.setTitleColor(.green, for: .normal)
        viewSelected.addSubview(buttonSelected)
        let line = UIView(frame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 1))
        line.backgroundColor = UIColor.graybackground
        pickerView.frame = CGRect(x : 0,y : 50,width: self.view.bounds.width, height: self.heightModal - 51)
        
        // add view
        contentModal.addSubview(viewSelected)
        contentModal.addSubview(line)
        contentModal.addSubview(pickerView)
        
        // add action
        let tapGesrure = UITapGestureRecognizer(target: self, action: #selector(_onClickSelectedMoney))
        buttonSelected.addGestureRecognizer(tapGesrure)
    }
    
    // view Modal
    func setupViewModal() {
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height + 88)
        window?.addSubview(transparentView)
        let screenSize = UIScreen.main.bounds.size
        contentModal.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.heightModal)
        contentModal.backgroundColor = .white
        window?.addSubview(contentModal)
        transparentView.alpha  = 0.5
        let tapGesrure = UITapGestureRecognizer(target: self, action: #selector(_closeModalSupportTicket))
        transparentView.addGestureRecognizer(tapGesrure)
        transparentView.alpha = 0
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.contentModal.frame = CGRect(x: 0, y: screenSize.height - self.heightModal, width: screenSize.width, height: self.heightModal)
        }, completion: nil)
    }
}

extension BorrowCreateViewController {
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
