//
//  GlanceController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import WatchKit
import Foundation
import RxSwift


/// The controller for the glance
class GlanceController: WKInterfaceController {
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    @IBOutlet var descriptionLabel: WKInterfaceLabel!
    
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    /// Dispose bag for the disposing of the observers
    var disposeBag = DisposeBag()
    
    /// View model to get the clicker data
    var viewModel: ClickerViewModel = ClickerViewModel()
    
    /// Settings view model
    var settingsViewModel: SettingsViewModel = SettingsViewModel()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        //Observe the view model clicker count, map it to a string and drive the label
        viewModel.clickerCountDriver?
            .map { String($0) }
            .driveNext{ [weak self] count in
                self?.countLabel.setText(count)
            }.addDisposableTo(disposeBag)
        
        
        /**
        *  Update the color of the label when the settings are change
        */
        settingsViewModel.settingsChangedSubject
            .subscribeNext{ [weak self] settings in
                
                self?.titleLabel.setTextColor(settings.color.uiColor)
                
                self?.countLabel.setTextColor(settings.color.uiColor)
                
                
            }.addDisposableTo(disposeBag)

        
        // Configure interface objects here.
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
    }

}
