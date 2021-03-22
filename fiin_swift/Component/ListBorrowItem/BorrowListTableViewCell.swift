//
//  BorrowListTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import UIKit

class BorrowListTableViewCell: UITableViewCell {

    @IBOutlet weak var statusName: UIButton!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var purposeName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
