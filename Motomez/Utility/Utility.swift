//
//  Utility.swift
//  Motomez
//
//  Created by Maze Geek on 7/5/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    
}
class Alerts {
    static func showActionsheet(viewController: UIViewController, title: String, message: String, actions: [(String, UIAlertActionStyle)], completion: @escaping (_ index: Int) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}
