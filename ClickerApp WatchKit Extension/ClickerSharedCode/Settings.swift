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
    
    /// Inverts the colors and the background, defaults to false
    public var invertColors: Bool = false
    
    // Storage and dictionary keys
    enum DictionaryKeys{
        
         static let color = "color"
         static let incrementMultiples = "incrementMultiplier"
         static let invertColors = "invertColors"
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
        
        if let invertColors = dictionary[DictionaryKeys.invertColors] as? Bool {
            self.invertColors = invertColors
        }
    }
    
    /**
     Function that convers the object to a dictionary
     
     - returns:
     */
    public func toDictionary() -> [String : AnyObject]
    {
        
        return [DictionaryKeys.color : self.color.rawValue, DictionaryKeys.incrementMultiples : self.incrementMultiplier, DictionaryKeys.invertColors: self.invertColors]
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
        
        self.invertColors = Bool.fromInt(decoder.decodeIntegerForKey(DictionaryKeys.invertColors))
        
        super.init()
    }
    
    /**
     Encode with coder
     
     - parameter coder: <#coder description#>
     */
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.color.rawValue, forKey: DictionaryKeys.color)
        coder.encodeInt(Int32(self.incrementMultiplier), forKey: DictionaryKeys.incrementMultiples)
        coder.encodeInt(Int32(self.invertColors.intValue), forKey: DictionaryKeys.invertColors)
    }
    
}

// MARK: - Background and tint color functionality
extension Settings{
    
    public var tintColor : UIColor{
        
        return self.invertColors ? self.color.uiColor : ClickerColors.BlackColor.uiColor
        
    }
    
    public var backgroundColor: UIColor {
        
        return self.invertColors ? ClickerColors.BlackColor.uiColor : self.color.uiColor
    }
    
    
}
