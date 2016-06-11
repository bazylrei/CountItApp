//
//  BooleanExtensionsSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 6/11/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Test for boolean extensions
class BooleanExtensionSpecs: QuickSpec {
    
    override func spec() {
        
        describe("Boolean extensions"){
            
            it("can convert from boolean fo int"){
                
                let valueInt = true.intValue
                
                expect(valueInt).to(equal(1))
            }
            
            it("can convert a int into bool"){
                
                expect(Bool.fromInt(0)).to(beFalse())
                expect(Bool.fromInt(1)).to(beTrue())
                
            }
            
        }
        
    }
}
