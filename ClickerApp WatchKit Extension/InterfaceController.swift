//
//  InterfaceController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import RxSwift


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var backgroundContainer: WKInterfaceGroup!
    
    @IBOutlet var clickerCountLabel: WKInterfaceLabel!
    
    @IBOutlet var clickerCountButton: WKInterfaceButton!
    
    var disposeBag = DisposeBag()
    
    var viewModel: ClickerViewModel = ClickerViewModel()
    
    var settingsViewModel: SettingsViewModel = SettingsViewModel()
    
    var incrementMultiplier: Int = 1

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        /**
        *  Observes the clicker count, maps it to a String and trive the label
        */
        viewModel.clickerCountDriver?
                    .map { String($0) }
                    .driveNext{ [weak self] count in
                        
                        self?.animateWithDuration(0.35, animations: { () -> Void in
                        
                            self?.clickerCountLabel.setText(count)
                        });
                        
                    }.addDisposableTo(disposeBag)
        
        
        /**
        *  Observes the settings change, update the multiplier and the background color
        */
        settingsViewModel.settingsChangedSubject
                         .subscribeNext{ [weak self] settings in
                            
                        //Add an animation for the transition
                        self?.animateWithDuration(1, animations: { () -> Void in
                                
                            self?.backgroundContainer.setBackgroundColor(settings.color.uiColor)
                        });
                            
                    self?.incrementMultiplier = settings.incrementMultiplier
            
            
        }.addDisposableTo(disposeBag)
    }
    
    /**
     Trigger when the view will activate
     */
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        viewModel.updateToLatestClicker()
        
        settingsViewModel.getLatestSettings()

    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /**
     Add to the counter when the option is clicked
     */
    @IBAction func clickedAddTouched() {
        
        viewModel.incrementClikerByMultiplier(incrementMultiplier)
        
    }
    
    /**
     Reset the counter when the menu
     */
    @IBAction func resetMenuTouched() {
        
        viewModel.resetClicker()
        
    }
    
    /**
     Substract the counter
     */
    @IBAction func substractMenuTouched() {
        
        viewModel.decrementClikerByMultiplier(incrementMultiplier)
    }
    
}

