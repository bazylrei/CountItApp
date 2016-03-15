//
//  Settings.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

public class Settings: NSObject, NSCoding, Dictionatable {
    
    
    /// The currentCount
    public var color: UIColor = UIColor.redColor()
    
    // Storage and dictionary keys
    private enum DictionaryKeys{
        
        static let color = "color"
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
        
        if let color = dictionary[DictionaryKeys.color] as? UIColor {
            self.color = color
        }
    }
    
    /**
     Function that convers the object to a dictionary
     
     - returns:
     */
    public func toDictionary() -> [String : AnyObject]
    {
        
        return [DictionaryKeys.color : self.color]
    }
    
    /**
     NSCoding complain initializer to save the clicker to storage
     
     - parameter decoder: <#decoder description#>
     
     - returns: <#return value description#>
     */
    public required init(coder decoder: NSCoder) {
        
        self.color = decoder.decodeObjectForKey(DictionaryKeys.color) as! UIColor
        super.init()
    }
    
    /**
     Encode with coder
     
     - parameter coder: <#coder description#>
     */
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.color, forKey: DictionaryKeys.color)
    }
    
}
