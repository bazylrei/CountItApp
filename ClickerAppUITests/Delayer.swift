//
//  Delayer.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

/// Just a delayer for simple UI Testing
public class Delayer{
    
    /**
     Delay for time 
     
     - parameter delay:   <#delay description#>
     - parameter closure: <#closure description#>
     */
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}