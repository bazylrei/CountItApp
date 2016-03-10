//
//  ViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var clickerCountLabel: UILabel!
    
    @IBOutlet weak var clickerButton: UIButton!
    
    let dataStorage = ClickerDataStorage()
    
    var clicker: Clicker = Clicker()
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
            
        setClickerCount()
        
        //Swift
        do {
            let applicationDict:[String:AnyObject] = ["clicker":clicker.toDictionary()]
            try session?.updateApplicationContext(applicationDict)
        } catch {
            // Handle errors here
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickerIncrementTouched(sender: AnyObject) {
        
       clicker.incrementCount()
        
       setClickerCount()
        
        //Swift
        do {
            let applicationDict:[String:AnyObject] = ["clicker":clicker.toDictionary()]
            try session?.updateApplicationContext(applicationDict)
        } catch {
            // Handle errors here
        }
        
        
    }
    
    func setClickerCount()
    {
        self.clickerCountLabel.text = clicker.description
        
        dataStorage.saveClicker(clicker)

    }

}

extension ViewController : WCSessionDelegate{
    
    // Receiving data
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        if let clickerDict = applicationContext["clicker"] as? [String:AnyObject]{
            
            self.clicker = Clicker(clickerDict: clickerDict)
            
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
               self?.setClickerCount()
            }
        }
    }
    
}

