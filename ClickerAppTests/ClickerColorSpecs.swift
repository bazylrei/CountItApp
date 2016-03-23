//
//  ClickerColorSpecs.swift
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
class ClickerColorSpecs: QuickSpec {
    
    override func spec() {
        
        describe("Basic color functionality"){
            
            it("Get UI Color"){
                
                expect(ClickerColors.BlueColor.uiColor).toNot(beNil())
            }
        }
    }
}
