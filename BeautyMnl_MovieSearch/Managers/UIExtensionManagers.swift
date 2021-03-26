//
//  UIExtensionManagers.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import UIKit

// MARK: - UIViewController
extension UIViewController {
    func showAlertPopup(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Reusability
protocol Reusable: class {
    static var className: String { get }
    static var nib: UINib { get }
}

extension Reusable {
    static var className: String {
        return "\(self)"
    }
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}
