//
//  InterfaceController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import WatchKit
import ClockKit
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
        
        viewModel.clickerCountDriver?
                    .map { String($0) }
                    .driveNext{ [weak self] count in
                        self?.clickerCountLabel.setText(count)
                    }.addDisposableTo(disposeBag)
        
        
        settingsViewModel.settingsChangedSubject
                         .subscribeNext{ [weak self] settings in
                            
                    self?.backgroundContainer.setBackgroundColor(settings.color.uiColor)
                            
                    self?.incrementMultiplier = settings.incrementMultiplier
            
            
        }.addDisposableTo(disposeBag)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        viewModel.updateToLatestClicker()
        
        settingsViewModel.getLatestSettings()

    }
    
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
         updateComplication()
    }
    

    @IBAction func clickedAddTouched() {
        
        viewModel.incrementClikerByMultiplier(incrementMultiplier)
        
    }
    

    @IBAction func resetMenuTouched() {
        
        viewModel.resetClicker()
        
    }
    
    @IBAction func substractMenuTouched() {
        
        viewModel.decrementClikerByMultiplier(incrementMultiplier)
    }
    
    func updateComplication()
    {
        
        let server = CLKComplicationServer.sharedInstance()
        
        for complication in server.activeComplications {
            server.reloadTimelineForComplication(complication)
        }

    }
    
}

