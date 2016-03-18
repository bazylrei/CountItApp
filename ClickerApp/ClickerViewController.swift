//
//  ViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit
import WatchConnectivity
import RxSwift
import RxCocoa

class ClickerViewController: UIViewController {

    @IBOutlet weak var clickerCountLabel: UILabel!
    
    @IBOutlet weak var clickerButton: UIButton!
    
    @IBOutlet weak var toolbar: UIToolbar!
    var disposeBag: DisposeBag = DisposeBag()
    
    let viewModel:ClickerViewModel = ClickerViewModel()
    
    let settingsViewModel: SettingsViewModel = SettingsViewModel()
    
    var multiplier: Int = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.clickerCountDriver?
                 .map{ String($0) }
                 .drive(clickerCountLabel.rx_text)
                 .addDisposableTo(disposeBag)
        
        
        settingsViewModel.settingsChangedDriver.driveNext { [weak self] settings in
            
            self?.view.backgroundColor = settings.color.uiColor
            
            self?.navigationController?.navigationBar.tintColor = settings.color.uiColor
            
            self?.toolbar.tintColor = settings.color.uiColor
            
            self?.multiplier = settings.incrementMultiplier
            
            self?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: settings.color.uiColor]
        
        }.addDisposableTo(disposeBag)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.updateToLatestClicker()
        
        settingsViewModel.getLatestSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickerIncrementTouched(sender: AnyObject) {
        
        viewModel.incrementClikerByMultiplier(multiplier)
        
    }

    @IBAction func clickerDecrementTouched(sender: AnyObject) {
        
        viewModel.decrementClikerByMultiplier(multiplier)
        
    }

    @IBAction func resetClickerTouched(sender: AnyObject) {
        
        let resetAlert = UIAlertController(title: "app_name".localized, message: "reset_message".localized, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .Cancel, handler: nil )
        
        resetAlert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "ok".localized, style: .Default){ [weak self] action in
             self?.viewModel.resetClicker()
        }
        
        resetAlert.addAction(okAction)
       
        self.presentViewController(resetAlert, animated: true, completion: nil)
        
    }
}


