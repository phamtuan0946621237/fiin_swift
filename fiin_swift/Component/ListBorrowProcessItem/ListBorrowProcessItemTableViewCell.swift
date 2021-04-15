//
//  ListBorrowProcessItemTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 3/27/21.
//

import UIKit

class ListBorrowProcessItemTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
