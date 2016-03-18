//
//  ClickerColors.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import UIKit

/// Colors to be used for the App
public enum ClickerColors : String{
    
    case RedColor    = "F40059"
    case BlueColor   = "1EEFC9"
    case YellowColor = "FDF855"
    case GreenColor  = "A2FB09"
    
    /// Gets the UIColor 
    var uiColor: UIColor{
        
        return UIColor(hexString: self.rawValue)!

    }

}
