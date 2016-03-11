//
//  ClickerViewModel.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/10/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

public class ClickerViewModel{
    
    let dataStorage : ClickerDataStorage = ClickerDataStorage()
    
    let watchSession : WatchSessionManager = WatchSessionManager.sharedManager
    
    var clicker: Clicker?{
        
        get{
            
           return nil
            
        }
        
    }
    
    
    public init(){}
    
    
    
    
}
