//
//  WatchSessionManager.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/10/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import WatchConnectivity


public protocol ApplicationContextChangedDelegate {
    func applicationContextDidUpdate(applicationContext: [String : AnyObject])
}

/// Manager for the WCSession object to be shared
public class WatchSessionManager: NSObject{
    
    static let sharedManager = WatchSessionManager()
    
    private var applicationContextChangedDelegates = [ApplicationContextChangedDelegate]()
    
    public override init(){
        super.init()
        
        session = WCSession.defaultSession()
    }
    
    var session: WCSession? {
        
        didSet{
            
            if let session = session
            {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    /// Get the latest received application context
    public var receivedApplicationContext: [String : AnyObject]? {
        
        get{
            
            if WCSession.isSupported() {
                
                if let session = session{
                
                    return session.receivedApplicationContext

                }
            }
            
            return nil
        }
    }
    
    /**
     Update the application context with a key and a description
     
     - parameter key:     Key to be use
     - parameter content: description
     */
    public func updateApplicationContext(withKey key:String, content:[String : AnyObject]){
        
        do {
            let applicationDict:[String:AnyObject] = [key:content]
            try session?.updateApplicationContext(applicationDict)
        } catch {
            print(error)
        }
    }
    
    
    /**
     Datasource delegate to be use when a new aplication context arrive
     
     - parameter delegate:
     */
    public func addDataSourceChangedDelegate<T where T: ApplicationContextChangedDelegate, T: Equatable>(delegate: T) {
        applicationContextChangedDelegates.append(delegate)
    }
    
    /**
     Remove the data source object
     
     - parameter delegate:
     */
    public func removeDataSourceChangedDelegate<T where T: ApplicationContextChangedDelegate, T: Equatable>(delegate: T) {
        for (index, indexDelegate) in applicationContextChangedDelegates.enumerate() {
            if let indexDelegate = indexDelegate as? T where indexDelegate == delegate {
                applicationContextChangedDelegates.removeAtIndex(index)
                break
            }
        }
    }
}

extension WatchSessionManager : WCSessionDelegate{
    
    // Receiving data
    public func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.applicationContextChangedDelegates.forEach {
                    $0.applicationContextDidUpdate(applicationContext)
            }
        }
    }
}
