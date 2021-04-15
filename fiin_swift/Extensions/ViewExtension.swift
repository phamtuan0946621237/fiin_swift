//
//  ViewExtension.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation
import UIKit
class ViewExtension : UIViewController {
    func buildAlertNotice(title : String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK bạn nhớ", style: .default, handler: { action in
        }))
        self.present(alert, animated: true)
    }
}

extension CALayer {

    func addBorder(edge: UIRectEdge, thickness: CGFloat) {

        var border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = UIColor.graybackground.cgColor;

        self.addSublayer(border)
    }

}

