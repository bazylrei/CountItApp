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


class GlanceController: WKInterfaceController {
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    @IBOutlet var descriptionLabel: WKInterfaceLabel!
    
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    var disposeBag = DisposeBag()
    
    var viewModel: ClickerViewModel = ClickerViewModel()
    
    var settingsViewModel: SettingsViewModel = SettingsViewModel()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        viewModel.clickerCountDriver?
            .map { String($0) }
            .driveNext{ [weak self] count in
                self?.countLabel.setText(count)
            }.addDisposableTo(disposeBag)
        
        
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
