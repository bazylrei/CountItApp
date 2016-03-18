//
//  AlertControllerBuilder.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/17/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import UIKit

/// Helper class to build AlertControllers
public class AlertControllerBuilder{
    
    
    /**
    Builds a simple Ok, Cancel alert with title, message and the action to be executed when the OK is clicked
     
     - parameter title:    <#title description#>
     - parameter message:  <#message description#>
     - parameter okAction: <#okAction description#>
     
     - returns: <#return value description#>
     */
    public class func buildOkCancelAlertWithTitle(title:String, message:String, okAction:(Void) -> Void) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .Cancel, handler: nil )
        
        let okAction = UIAlertAction(title: "ok".localized, style: .Default){ action in
            okAction()
        }
        
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        return alertController
        
    }
    
}
