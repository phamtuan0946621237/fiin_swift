//
//  YoutubeMatchFactsUIView.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit

class ModalSupportTicket: UIView {
    
    
    @IBOutlet weak var sendSupportView: UIView!
    @IBOutlet weak var titleSupport: UIView!
    @IBOutlet weak var titleView: UILabel!
    let nibName = "ModalSupportTicket"
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

    override init(frame: CGRect) {
            
        super.init(frame: frame)
            
            commonInit()
        }
        
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            
            self.addSubview(view)
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
}
