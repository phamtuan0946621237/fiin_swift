//
//  ListSupportTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 3/10/21.
//

import UIKit

class ListSupportTableViewCell: UITableViewCell {

    @IBOutlet weak var statusSupport: UILabel!
    @IBOutlet weak var timeSupport: UILabel!
    @IBOutlet weak var titleSupport: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        statusSupport.layer.cornerRadius = 12
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
