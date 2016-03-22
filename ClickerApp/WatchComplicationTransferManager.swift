//
//  ComplicationTransferManager.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/20/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import WatchConnectivity

/// Complication manager to update the complication if installed
public class WatchComplicationManager: NSObject{
    
    /**
     Initilize the WCSession
     
     - returns: <#return value description#>
     */
    public override init(){
        super.init()
        
        session = WCSession.defaultSession()
        session?.activateSession()
    }
    
    public var session: WCSession?
   
    /**
     Transfer data to complication
     
     - parameter key:     key of the dictionary to use
     - parameter content: content to transfer
     */
    public func updateComplication(withKey key:String, content:[String : AnyObject]){
        
        
        let applicationDict:[String:AnyObject] = [key:content]
        
        session?.transferCurrentComplicationUserInfo(applicationDict)
        
    }
}
