//
//  DesignableView.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable public var shadowColor: CGColor = UIColor.black.cgColor {
        didSet {
            self.layer.shadowColor = shadowColor
        }
    }

}
