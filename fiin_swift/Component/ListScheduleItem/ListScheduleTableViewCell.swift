//
//  ListScheduleTableViewCell.swift
//  fiin_swift
//
//  Created by admin on 4/15/21.
//

import UIKit

class ListScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var hopdong: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
