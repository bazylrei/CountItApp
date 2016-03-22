//
//  Settings.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

public class Settings: NSObject, NSCoding, Dictionatable {
    
    
    ///The selected setting color, defaults to red color
    public var color: ClickerColors = ClickerColors.RedColor
    
    /// The increment multiplier, defaults to 1
    public var incrementMultiplier : Int  = 1
    
    // Storage and dictionary keys
    private enum DictionaryKeys{
        
        static let color = "color"
        static let incrementMultiples = "incrementMultiplier"
    }
    
    /**
     Default init
     
     - returns:
     */
    public override init() {
        super.init()
    }
    
    /**
     Convenience init that initialize the clicker with a dictionary of data
     
     - parameter clickerDict:
     
     - returns:
     */
    public convenience required init(dictionary: [String : AnyObject]) {
        self.init()
        
        if let color = dictionary[DictionaryKeys.color] as? String {
            self.color = ClickerColors(rawValue: color)!
        }
        
        if let incrementsMultiples = dictionary[DictionaryKeys.incrementMultiples] as? Int {
            self.incrementMultiplier = incrementsMultiples
        }
    }
    
    /**
     Function that convers the object to a dictionary
     
     - returns:
     */
    public func toDictionary() -> [String : AnyObject]
    {
        
        return [DictionaryKeys.color : self.color.rawValue, DictionaryKeys.incrementMultiples : self.incrementMultiplier]
    }
    
    /**
     NSCoding complain initializer to save the clicker to storage
     
     - parameter decoder: <#decoder description#>
     
     - returns: <#return value description#>
     */
    public required init(coder decoder: NSCoder) {
        
        let colorString = decoder.decodeObjectForKey(DictionaryKeys.color) as! String
        self.color = ClickerColors(rawValue: colorString)!
        
        self.incrementMultiplier = decoder.decodeIntegerForKey(DictionaryKeys.incrementMultiples)
        
        
        super.init()
    }
    
    /**
     Encode with coder
     
     - parameter coder: <#coder description#>
     */
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.color.rawValue, forKey: DictionaryKeys.color)
        coder.encodeInt(Int32(self.incrementMultiplier), forKey: DictionaryKeys.incrementMultiples)
    }
    
}
