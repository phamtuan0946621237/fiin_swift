//
//  ListBankInfoTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 3/15/21.
//

import UIKit

class ListBankInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var nameHolder: UILabel!
    @IBOutlet weak var branch: UILabel!
    @IBOutlet weak var stk: UILabel!
    @IBOutlet weak var nameBank: UILabel!
    @IBOutlet weak var iconBank: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.layer.cornerRadius = 8
        viewMain.layer.borderWidth = 1
        let yourColor : UIColor = UIColor(red: 66/255, green: 83/255, blue: 161/255, alpha: 1.0)
        viewMain.layer.borderColor = yourColor.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
