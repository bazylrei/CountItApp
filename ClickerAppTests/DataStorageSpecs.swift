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

/// Test for the color extensions
class DataStorageSpecs: QuickSpec {
    
    var dataStorage: DataStorage = DataStorage()
    
    override func spec() {
        
        beforeEach {
            self.dataStorage = DataStorage()
        }
        
        describe("Clicker storage"){
            
            it("save and get valid clicker"){
                
                let clicker = Clicker()
                
                self.dataStorage.saveClicker(clicker)
                
                expect(self.dataStorage.getClicker().currentCount).to(equal(0))
                
                
            }
            
        }
        
       
    }
}

