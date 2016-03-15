//
//  ClickerDataStorage.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

/**
 *  NSUserDefault storage of the clicker instance
 */
public class DataStorage {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    public init(){}
    
    /// Storage keys
    private enum StorageKeys{
        
        static let clicker = "clicker"
        static let settings = "settings"
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
    
    
    /**
     Retunrns the settings saved in the datastorage
     
     - returns: <#return value description#>
     */
    public func getSettings() -> Settings{
        
        var settings = Settings()
        
        if let settingsData = defaults.dataForKey(StorageKeys.settings) {
            
            settings = NSKeyedUnarchiver.unarchiveObjectWithData(settingsData) as! Settings
            
        }
        
        return settings
    }
    
    /**
     Gets the settings from the data storage
     
     - parameter settings: Save settings
     */
    public func saveSettings(settings : Settings){
        
        let settingsData = NSKeyedArchiver.archivedDataWithRootObject(settings)
        
        defaults.setObject(settingsData, forKey: StorageKeys.settings)
        
        defaults.synchronize()
        
    }
}

