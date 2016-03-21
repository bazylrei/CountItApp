//
//  ComplicationTransferManager.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/20/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import WatchConnectivity


public class WatchComplicationManager: NSObject{
    
    public override init(){
        super.init()
        
        session = WCSession.defaultSession()
        session?.activateSession()
    }
    
    var session: WCSession?
   
    public func updateComplication(withKey key:String, content:[String : AnyObject]){
        
        
        let applicationDict:[String:AnyObject] = [key:content]
        
        session?.transferCurrentComplicationUserInfo(applicationDict)
        
    }
}
