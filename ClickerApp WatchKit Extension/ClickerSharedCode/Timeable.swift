//
//  Timeable.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/27/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation


public protocol Timeable : Comparable{
    
    var timeStamp:NSDate {get set}
}


    /**
     Timeable is compared by the timestamp      
     - parameter lhs: <#lhs description#>
     - parameter rhs: <#rhs description#>
     
     - returns: <#return value description#>
     */
public func == <T : Timeable>(lhs: T, rhs: T) -> Bool {
    return lhs.timeStamp === rhs.timeStamp || lhs.timeStamp.compare(rhs.timeStamp) == .OrderedSame
}
    
public func < <T : Timeable>(lhs: T, rhs: T) -> Bool {
    return lhs.timeStamp.compare(rhs.timeStamp) == .OrderedAscending
}





