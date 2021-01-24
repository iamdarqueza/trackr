//
//  UIViewController+Alerts.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation
import UIKit

extension UIViewController {

    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        alertController.addAction(dismissAlertAction)

        present(alertController, animated: true, completion: nil)

        return alertController
    }

    func presentLoadingAlertController(title: String? = "Loading...", completion: (() -> Swift.Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: "Please wait.", preferredStyle: .alert)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 110)
        alertController.view.addConstraint(height);

        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: alertController.view.bounds)
        loadingIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingIndicator.style = .gray
        loadingIndicator.center = CGPoint(x: alertController.view.center.x, y: alertController.view.center.y + 25)
        alertController.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()

        present(alertController, animated: true, completion: completion)

        return alertController
    }

    func presentErrorAlertController(error: Error) {
        let title = error.localizedDescription
        presentDismissableAlertController(title: title, message: nil)
    }

    func presentErrorAlertController(error: Error, withBlock completion: @escaping () -> Void) {
        let title = error.localizedDescription
        presentDismissableAlertController(title: title, message: nil, withBlock: {
            completion()
        })
    }

    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?, withBlock completion: @escaping () -> Void ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            completion()
        }

        alertController.addAction(dismissAlertAction)

        present(alertController, animated: true, completion: nil)

        return alertController
    }
}
