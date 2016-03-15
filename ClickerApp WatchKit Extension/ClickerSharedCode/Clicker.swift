//
//  Clicker.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/9/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

/**
 *  Clicker to countain the current ecount
 */
public class Clicker: NSObject, NSCoding, Dictionatable{
    
    /// The currentCount
    public var currentCount: Int = 0
    // The timestamp of the count, used for storage and syncing between watch and device
    public var timeStamp : NSDate = NSDate()
    
    // Storage and dictionary keys
    private enum DictionaryKeys{
        
        static let currentCount = "currentCount"
        static let timeStamp  = "timeStamp"
    }
    
    /**
     Default init
     
     - returns:
     */
    public override init() {
        super.init()
    }
    
    /**
     Conveniece init that initialize a clicker with a current count
     
     - parameter currentCount: <#currentCount description#>
     
     - returns: <#return value description#>
     */
    public convenience init(currentCount: Int){
        
        self.init()
        self.currentCount = currentCount
        self.timeStamp = NSDate();
        
    }
    
    /**
     Convenience init that initialize the clicker with a dictionary of data
     
     - parameter clickerDict:
     
     - returns:
     */
    public convenience required init(dictionary: [String : AnyObject]) {
        self.init()
        
        if let currentCount = dictionary[DictionaryKeys.currentCount] as? Int {
            self.currentCount = currentCount
        }
        
        if let timeStamp = dictionary[DictionaryKeys.timeStamp] as? NSDate{
            self.timeStamp = timeStamp
        }
        
    }
    
    /**
     Function that convers the object to a dictionary
     
     - returns:
     */
    public func toDictionary() -> [String : AnyObject]
    {
        
        return [DictionaryKeys.currentCount : self.currentCount ,
                DictionaryKeys.timeStamp : self.timeStamp]
    }
    
    /**
     NSCoding complain initializer to save the clicker to storage
     
     - parameter decoder: <#decoder description#>
     
     - returns: <#return value description#>
     */
    public required init(coder decoder: NSCoder) {
       
        self.currentCount = decoder.decodeIntegerForKey(DictionaryKeys.currentCount)
        self.timeStamp = decoder.decodeObjectForKey(DictionaryKeys.timeStamp) as! NSDate
        super.init()
    }
    
    /**
     Encode with coder
     
     - parameter coder: <#coder description#>
     */
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.currentCount), forKey: DictionaryKeys.currentCount)
        coder.encodeObject(self.timeStamp, forKey: DictionaryKeys.timeStamp)
    }
    
    /// Our toString function
    public override var description: String {
        
        get{
            return String(currentCount)
        }
    }
    
    /**
     Increment the count and update the timestamp
     */
    public func incrementCount(){
        
       currentCount = currentCount + 1
       timeStamp = NSDate()
        
    }
    
    /**
     Decrement the count by one and update the timestamp
     */
    public func decrementCount(){
        
        currentCount = currentCount - 1
        timeStamp = NSDate()
        
    }
    
    /**
     Reset the count and update the time stamp
     */
    public func resetCount()
    {
        currentCount = 0
        timeStamp = NSDate()
    }
  
}

// MARK: - Comparable
extension Clicker : Comparable{}

/**
 Clicker is compared by the timestamp not by the clicker values
 
 - parameter lhs: <#lhs description#>
 - parameter rhs: <#rhs description#>
 
 - returns: <#return value description#>
 */
func == (lhs: Clicker, rhs: Clicker) -> Bool {
    return lhs.timeStamp === rhs.timeStamp || lhs.timeStamp.compare(rhs.timeStamp) == .OrderedSame
}

public func < (lhs: Clicker, rhs: Clicker) -> Bool {
    return lhs.timeStamp.compare(rhs.timeStamp) == .OrderedAscending
}
