//
//  DataStorageSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/22/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Test for the data storage functionality
class DataStorageSpecs: QuickSpec {
    
    var dataStorage: DataStorage = DataStorage()
    
    override func spec() {
        
        beforeEach {
            self.dataStorage = DataStorage()
        }
        
        describe("Clicker storage"){
            
            it("save and get valid clicker"){
                
                let clicker = Clicker()
                
                let currentCount = 5
                
                clicker.currentCount = currentCount
                
                self.dataStorage.saveClicker(clicker)
                
                expect(self.dataStorage.getClicker().currentCount).to(equal(currentCount))
                
            }
            
        }
        
        
        describe("Settings storage"){
            
            it("save and get the settings from the storage"){
                
                let settings = Settings()
                
                let incrementMultiplier = 2
                
                settings.incrementMultiplier = incrementMultiplier
                
                self.dataStorage.saveSettings(settings)
                
                expect(self.dataStorage.getSettings().incrementMultiplier).to(equal(incrementMultiplier))
                
            }
            
        }
        
    }
}

