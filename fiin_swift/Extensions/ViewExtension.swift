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

