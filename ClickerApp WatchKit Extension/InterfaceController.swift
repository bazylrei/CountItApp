//
//  InterfaceController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet var clickerCountLabel: WKInterfaceLabel!
    
    
    @IBOutlet var clickerCountButton: WKInterfaceButton!
    
    let dataStorage = ClickerDataStorage()
    
    var clicker: Clicker?  = Clicker(){
        
        didSet{
            setClickerLabel()
        }
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
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        

        if WCSession.isSupported() {
            
            session = WCSession.defaultSession()
            
            if let clickerDict = session?.receivedApplicationContext["clicker"] as? [String : AnyObject]{
                
                let clicker = Clicker(clickerDict: clickerDict)
                
                let clickerStored = dataStorage.getClicker()
                
                if clicker > clickerStored{
                    
                    self.clicker = clicker
                }
                else{
                    self.clicker = clickerStored
                }
                
            }
            else
            {
                self.clicker = dataStorage.getClicker()
            }
            
        }

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func clickedAddTouched() {
        
        if let clicker = clicker{
            
             clicker.incrementCount()
            
            setClickerLabel()
            
            do {
                let applicationDict:[String:AnyObject] = ["clicker":clicker.toDictionary()]
                try session?.updateApplicationContext(applicationDict)
            } catch {
                // Handle errors here
            }


        }
        
    }
    
    func setClickerLabel()
    {
        
        self.clickerCountLabel.setText(clicker?.description)
        
        dataStorage.saveClicker(clicker!)
        
    }
}

extension InterfaceController : WCSessionDelegate{
    
    // Receiving data
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        if let clickerDict = applicationContext["clicker"] as? [String:AnyObject]{
            
            self.clicker = Clicker(clickerDict: clickerDict)
            
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                 self?.setClickerLabel()
            }
        }
    }

}
