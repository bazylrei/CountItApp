//
//  SettingsViewModelSpecs.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/23/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import Nimble
import Quick
import ClickerApp
import RxSwift

/// Clicker View model tests
class SettingsViewModelSpecs: QuickSpec {
    
    var viewModel = SettingsViewModel()
    var disposeBag = DisposeBag()
    
    override func spec() {
        
        beforeEach {
            self.viewModel = SettingsViewModel()
        }
        
        describe("Settings ViewModel Functionality"){
            
            it("Change settings, increment multiplier"){
                
                var incrementMultiplier = 0
                
                self.viewModel.settingsChangedDriver
                    .map { $0.incrementMultiplier }
                    .driveNext{ increment in
                        
                        incrementMultiplier = increment
                        
                    }.addDisposableTo(self.disposeBag)
                
                
                self.viewModel.setIncrementsMultiple(5)
                
                expect(incrementMultiplier).toEventuallyNot(equal(0),timeout:2)
                
            }
            
            it("Change settings, change color"){
                
                var color = ""
                
                self.viewModel.settingsChangedDriver
                    .map { $0.color }
                    .driveNext{ colorIn in
                        
                        color = colorIn.rawValue
                        
                    }.addDisposableTo(self.disposeBag)
                
                
                self.viewModel.setIncrementsMultiple(5)
                
                expect(color).toEventuallyNot(equal(""),timeout:2)
                
            }
        }
    }
}
