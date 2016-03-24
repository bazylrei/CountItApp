//
//  ClickerViewModelSpecs.swift
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
class ClickerViewModelSpecs: QuickSpec {
    
    var viewModel = ClickerViewModel()
    var disposeBag = DisposeBag()
    
    override func spec() {
        
        beforeEach {
            self.viewModel = ClickerViewModel()
        }
        
        describe("Clicker ViewModel Functionality"){
            
            it("increment clicker"){
                
                var clickerString = ""
                
                self.viewModel.clickerCountDriver?
                    .map { $0.description }
                    .driveNext{ count in
                        
                        clickerString = count
                        
                    }.addDisposableTo(self.disposeBag)

                
                self.viewModel.incrementClikerByMultiplier()
                
                expect(clickerString).toEventuallyNot(equal(""),timeout:2)
                
            }
        }
    }
}
