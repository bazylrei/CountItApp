//
//  ClickerColors.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import UIKit

public enum ClickerColors : String{
    
    case RedColor = "F10045"
    case BlueColor = "1EEFC9"
    case YellowColor = "FDF855"
    case GreenColor = "A2FB09"
    
    var uiColor: UIColor{
        
        return UIColor(hexString: self.rawValue)!

    }
        
    
    

}
