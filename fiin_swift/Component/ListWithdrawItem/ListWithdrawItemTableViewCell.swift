//
//  ListWithdrawItemTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 3/30/21.
//

import UIKit

class ListWithdrawItemTableViewCell: UITableViewCell {
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var numberAccount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.status.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
