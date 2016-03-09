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
public struct ClickerDataStorage {
    
    let defaults = NSUserDefaults.init(suiteName: "group.com.greenpixels.clicker")
    
    public init(){}
    
    /// Storage keys
    private enum StorageKeys{
        
        static let clickerCountKey = "ClickerCount"
    }
    
   
    /**
     Gets the clicker current count
     
     - returns: <#return value description#>
     */
    public func getClickerCount() -> Int{
        
        var count = 0
        if let clickerCount = defaults?.integerForKey(StorageKeys.clickerCountKey) {
            count = clickerCount
        }
        return count
    }
    
    /**
     Set the clicker current count
     
     - parameter count: <#count description#>
     */
    public func setClickerCount(count : Int){
        
        defaults?.setValue(count, forKey: StorageKeys.clickerCountKey)
        
        defaults?.synchronize()
        
    }
    
    
    /**
     Increment the count by one
     */
    public func incrementCount(){
        
        let currentCount = getClickerCount()
        
        setClickerCount(currentCount + 1)
        
    }
    
    /**
     Decrement the count by one
     */
    public func decrementCount(){
        
        let currentCount = getClickerCount()
        
         setClickerCount(currentCount - 1)
        
    }
    
    /**
     Reset the count
     */
    public func resetCount()
    {
        defaults?.removeObjectForKey(StorageKeys.clickerCountKey)
        setClickerCount(0)
    }
    
}

