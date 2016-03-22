//
//  UIColor-LighterDarker.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/15/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension to get Lighter or darker colors
public extension UIColor{
    
    /**
     Returns a darker color tone
     
     - returns: <#return value description#>
     */
    func darkerColor() -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        
        return self
    }
    
    /**
     Returns a ligter color tone
     
     - returns: <#return value description#>
     */
    func lighterColor() -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
        }
        
        return self
    }
}
