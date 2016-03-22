//
//  AlertControllerBuilderSpecs.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/22/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

import Nimble
import Quick
import ClickerApp

/// Specs of the alert controller util
class AlertControllerBuilderSpecs: QuickSpec {
    
    override func spec() {
        
        it("build valid alert controller"){
            
            let alertController = AlertControllerBuilder.buildOkCancelAlertWithTitle("test", message: "this is a test", okAction: {})
            
            expect(alertController).toNot(beNil())
            expect(alertController.actions.count).to(equal(2))
            expect(alertController.actions[0].title).to(equal("Cancel"))
            expect(alertController.actions[1].title).to(equal("Ok"))
            
        }
        
    }
}