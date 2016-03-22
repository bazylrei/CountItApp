//
//  UIColorExtensionsSpecs.swift
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
class UIColorExtensionSpecs: QuickSpec {
    
    override func spec() {
        
        describe("UIColorHex"){
        
            it("build valid Color Hex"){
            
                let hexColor = UIColor(hexString: "FFFFFF")
            
                expect(hexColor).toNot(beNil())
            }
        
        }
        
        describe("Darker and lighter colors"){
            
            
            it("builds a color darker color"){
                
                
                let darkerColor = UIColor.blackColor().darkerColor()
                
                expect(darkerColor).toNot(beNil())
            }
            
            it("build a lighter color"){
                
                let lighterColor = UIColor.blackColor().lighterColor()
                
                expect(lighterColor).toNot(beNil())
            }
            
        }
    }
}
