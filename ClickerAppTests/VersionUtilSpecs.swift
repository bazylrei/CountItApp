//
//  VersionUtilSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/22/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp


/// Version Util Specs
class VersionUtilSpecs: QuickSpec {
    
    override func spec() {
        
        it("is valid with app version"){
            
            let version = VersionUtil.getAppVersion()
            
            expect(version).toNot(beNil())
            expect(version).toNot(beEmpty())

        }
        
    }
}