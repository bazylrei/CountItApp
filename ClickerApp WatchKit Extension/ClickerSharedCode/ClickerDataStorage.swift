//
//  ClickerDataStorage.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

/**
 *  Basic class to handle the clicker count values
 */
public class ClickerDataStorage {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    public init(){}
    
    /// Storage keys
    private enum StorageKeys{
        
        static let clicker = "clicker"
    }
    
    
    /**
     Gets the clicker current count
     
     - returns: <#return value description#>
     */
    public func getClicker() -> Clicker{
        
        var clicker = Clicker()
        
        if let clickerData = defaults.dataForKey(StorageKeys.clicker) {
            
            clicker = NSKeyedUnarchiver.unarchiveObjectWithData(clickerData) as! Clicker
            
        }
        
        return clicker
    }
    
    /**
     Set the clicker current count
     
     - parameter count: <#count description#>
     */
    public func saveClicker(clicker : Clicker){
        
        let clickerData = NSKeyedArchiver.archivedDataWithRootObject(clicker)
        
        defaults.setObject(clickerData, forKey: StorageKeys.clicker)
        
        defaults.synchronize()
        
    }
}

