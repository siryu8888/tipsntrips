//
//  AlertManager.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/8/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class AlertManager: NSObject {

    static let sharedInstance = AlertManager()
    
    func alertOKOnly(_ title:String,msg:String) -> UIAlertController
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        return alertController
    }
}
