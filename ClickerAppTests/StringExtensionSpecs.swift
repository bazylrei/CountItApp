//
//  StringExtensionSpecs.swift
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
class StringExtensionSpecs: QuickSpec {
    
    override func spec() {
        
        describe("String extensions"){
            
            it("get valid localized string"){
                
                let appName = "app_name".localized
                
                expect(appName).toNot(beNil())
                expect(appName).toNot(beEmpty())
            }
            
        }
        
    }
}
