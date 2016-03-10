//
//  Clicker.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/9/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

/**
 *  Clicker model that contains the current count
 */
public class Clicker: NSObject, NSCoding{
    
    public var currentCount: Int = 0
    
    public var timeStamp : NSDate = NSDate()
    
    // Storage keys
    private enum DictionaryKeys{
        
        static let currentCount = "currentCount"
        static let timeStamp  = "timeStamp"
    }
    
    public override init() {
        super.init()
    }
    
    public convenience init(currentCount: Int){
        
        self.init()
        self.currentCount = currentCount
        self.timeStamp = NSDate();
        
    }
    
    public convenience init(clickerDict: [String : AnyObject]) {
        self.init()
        
        if let currentCount = clickerDict[DictionaryKeys.currentCount] as? Int {
            self.currentCount = currentCount
        }
        
        if let timeStamp = clickerDict[DictionaryKeys.timeStamp] as? NSDate{
            self.timeStamp = timeStamp
        }
        
    }
    
    public func toDictionary() -> [String : AnyObject]
    {
        
        return [DictionaryKeys.currentCount : self.currentCount ,
                DictionaryKeys.timeStamp : self.timeStamp]
    }
    
    // MARK: NSCoding
    public required init(coder decoder: NSCoder) {
        //Error here "missing argument for parameter name in call
        self.currentCount = decoder.decodeIntegerForKey(DictionaryKeys.currentCount)
        self.timeStamp = decoder.decodeObjectForKey(DictionaryKeys.timeStamp) as! NSDate
        super.init()
    }
    
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.currentCount), forKey: DictionaryKeys.currentCount)
        coder.encodeObject(self.timeStamp, forKey: DictionaryKeys.timeStamp)
    }
    
    /// ToString
    public override var description: String {
        
        get{
            return String(currentCount)
        }
    }
    
    /**
     Increment the count by one
     */
    public func incrementCount(){
        
       currentCount = currentCount + 1
        timeStamp = NSDate()
        
    }
    
    /**
     Decrement the count by one
     */
    public func decrementCount(){
        
        currentCount = currentCount - 1
        timeStamp = NSDate()
        
    }
    
    /**
     Reset the count
     */
    public func resetCount()
    {
        currentCount = 0
        timeStamp = NSDate()
    }
  
}


extension Clicker : Comparable{}

func == (lhs: Clicker, rhs: Clicker) -> Bool {
    return lhs.timeStamp === rhs.timeStamp || lhs.timeStamp.compare(rhs.timeStamp) == .OrderedSame
}

public func < (lhs: Clicker, rhs: Clicker) -> Bool {
    return lhs.timeStamp.compare(rhs.timeStamp) == .OrderedAscending
}
