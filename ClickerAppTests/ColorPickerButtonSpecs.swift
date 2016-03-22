//
//  ColorPickerButtonSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/22/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp

/// Test for the clicker button
class ColorPickerButtonSpecs: QuickSpec {
    
    override func spec() {
        
        it("build valid ColorPickerButton"){
            
            let colorPickerButton = ColorPickerButton(coder: NSCoder.empty())
            
            colorPickerButton?.setupWithColor(UIColor.blackColor())
            
            
            expect(colorPickerButton).toNot(beNil())
            expect(colorPickerButton?.layer.borderColor).toNot(beNil())
            expect(colorPickerButton?.layer.cornerRadius).toNot(beNil())
            expect(colorPickerButton?.layer.backgroundColor).toNot(beNil())
            expect(colorPickerButton?.titleForState(UIControlState.Normal)).to(beEmpty())
            
        }
        
    }
}
