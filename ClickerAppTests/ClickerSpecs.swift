//
//  ClickerSpecs.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/23/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Clicker Model specs
class ClickerSpecs: QuickSpec {
    
    var clicker = Clicker()
    
    override func spec() {
        
        beforeEach {
            self.clicker = Clicker()
        }
        
        describe("Clicker functionality"){
            
            it("increment clicker"){
                
                
                self.clicker.incrementCountByMultiplier(2)
                
                self.clicker.incrementCountByMultiplier(2)
                
                expect(self.clicker.currentCount).to(equal(4))
                expect(self.clicker.timeStamp).toNot(beNil())
                
            }
            
            it("decrement clicker")
            {
                self.clicker.incrementCountByMultiplier(2)
                
                self.clicker.decrementCountByMultiplier(2)
                
                expect(self.clicker.currentCount).to(equal(0))
                expect(self.clicker.timeStamp).toNot(beNil())
            }
            
            it("reset clicker")
            {
                self.clicker.incrementCountByMultiplier(10)
                
                self.clicker.resetCount()
                
                expect(self.clicker.currentCount).to(equal(0))
                expect(self.clicker.timeStamp).toNot(beNil())
            }
            
            it("get description")
            {
                self.clicker.incrementCountByMultiplier(2)
                
                expect(self.clicker.description).to(equal("2"))
            }
            
            it("get description")
            {
                self.clicker.incrementCountByMultiplier(2)
                
                expect(self.clicker.description).to(equal("2"))
            }
            
            it("gets dictionary")
            {
                self.clicker.incrementCountByMultiplier(2)
                
                let dict = self.clicker.toDictionary()
                
                expect(dict).toNot(beNil())
                expect(dict[Clicker.DictionaryKeys.currentCount]).toNot(beNil())
                expect(dict[Clicker.DictionaryKeys.timeStamp]).toNot(beNil())
            }
            
            it("sets dictionary")
            {
                
                let dict = [Clicker.DictionaryKeys.currentCount:1, Clicker.DictionaryKeys.timeStamp:NSDate()]
                let clicker = Clicker(dictionary:dict)
                
                expect(clicker).toNot(beNil())
                expect(clicker.currentCount).to(equal(1))
                expect(clicker.timeStamp).toNot(beNil())
                
            }
            
            it("compares clickers")
            {
                
               let secondClicker = Clicker()
                
               var equals = true
                
               if(self.clicker < secondClicker){
                    equals = false
               }
                
               expect(equals).to(beFalse())
                
            }
            
            
            it("Clicker are equals")
            {
                
                expect(self.clicker).to(equal(self.clicker))
                
            }

        }
    }
    
}
