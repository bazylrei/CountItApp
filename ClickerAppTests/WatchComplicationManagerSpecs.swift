//
//  WatchComplicationManagerSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/22/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Watch complication manager util tests
class WatchComplicationManagerSpecs: QuickSpec {
    
    override func spec() {
        
        it("build valid complication manager"){
            
            let complicationManager:WatchComplicationManager? = WatchComplicationManager()
            
            expect(complicationManager?.session).toNot(beNil())
            
        }
        
    }
}
