//
//  SettingsSpecs.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/23/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Settings Model Specs
class SettingsSpecs: QuickSpec {
    
    var settings = Settings()
    
    override func spec() {
        
        beforeEach {
            self.settings = Settings()
        }
        
        describe("Settings basic functionality"){
            
            it("initialize values"){
                
                expect(self.settings.color).toNot(beNil())
                expect(self.settings.incrementMultiplier).to(equal(1))
                expect(self.settings.color).to(equal(ClickerColors.RedColor))
                
            }
            
            it("gets dictionary")
            {
                
                let dict = self.settings.toDictionary()
                
                expect(dict).toNot(beNil())
                expect(dict[Settings.DictionaryKeys.color]).toNot(beNil())
                expect(dict[Settings.DictionaryKeys.incrementMultiples]).toNot(beNil())
            }
            
            it("sets dictionary")
            {
                
                let dict = [Settings.DictionaryKeys.color:ClickerColors.BlueColor.rawValue, Settings.DictionaryKeys.incrementMultiples:3]
                
                
                let settingsFromDict = Settings(dictionary: dict as! [String : AnyObject])
                
                expect(settingsFromDict).toNot(beNil())
                
            }
        }
    }
}
