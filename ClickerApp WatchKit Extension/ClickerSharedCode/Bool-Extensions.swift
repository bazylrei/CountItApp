//
//  Bool-Extensions.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 6/11/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

// MARK: - Boolean extension
extension Bool {
    
    
    /// Converts a boolean object to Int
    public var intValue: Int{
        
        return self == true ? 1 : 0
        
    }
    
    public static func fromInt(intValue: Int) -> Bool {
        
        guard intValue == 1 || intValue == 0 else{
        //TODO: Throw exeption here
            return false
        }
        
        return intValue == 1 ? true : false
        
    }
    

}
