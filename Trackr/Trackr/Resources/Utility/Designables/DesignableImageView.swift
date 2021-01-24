//
//  DesignableImageView.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation
import UIKit

@IBDesignable
class DesignableImageView: UIImageView {

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = layer.frame.height / 2
            layer.masksToBounds = newValue > 0
        }
    }
}
