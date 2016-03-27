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
public struct DataStorage {
    
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
        
        if let clickerFromStorage = getObjectWithKey(StorageKeys.clicker) as? Clicker {
            
            clicker = clickerFromStorage
            
        }
        
        return clicker
    }
    
    /**
     Set the clicker current count
     
     - parameter count: <#count description#>
     */
    public func saveClicker(clicker : Clicker){
        
        self.saveObject(clicker, withKey: StorageKeys.clicker)
        
    }
    
    
    /**
     Retunrns the settings saved in the datastorage
     
     - returns: <#return value description#>
     */
    public func getSettings() -> Settings{
        
        var settings = Settings()
        
        if let settingsFromStorage = getObjectWithKey(StorageKeys.settings) as? Settings{
            
            settings = settingsFromStorage
            
        }
        
        return settings
    }
    
    /**
     Gets the settings from the data storage
     
     - parameter settings: Save settings
     */
    public func saveSettings(settings : Settings){
        
        
        self.saveObject(settings, withKey: StorageKeys.settings)
        
    }
    
    
    /**
     Save the object to the data storage
     
     - parameter object: Object to be save
     - parameter key:    key of the storage
     */
    private func saveObject(object: NSCoding, withKey key: String){
        
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(object)
        
        defaults.setObject(data, forKey: key)
        
        defaults.synchronize()
        
    }
    
    /**
     Get the object with key from the datastorage
     
     - parameter key: key of the object
     
     - returns: objet from the storage
     */
    private func getObjectWithKey(key: String) -> AnyObject?{
        
        var object: AnyObject? = nil
        
        if let data = defaults.dataForKey(key) {
            
            object = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            
        }
        
        return object
    }
}

