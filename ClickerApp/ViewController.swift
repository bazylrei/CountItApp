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

class ViewController: UIViewController {

    @IBOutlet weak var clickerCountLabel: UILabel!
    
    @IBOutlet weak var clickerButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let viewModel:ClickerViewModel = ClickerViewModel()
    
    let settingsViewModel: SettingsViewModel = SettingsViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.clickerCountDriver?
                 .map{ String($0) }
                 .drive(clickerCountLabel.rx_text)
                 .addDisposableTo(disposeBag)
        
        
        settingsViewModel.settingsChangedDriver.driveNext { [weak self] settings in
            
            self?.view.backgroundColor = settings.color.uiColor
            
            self?.navigationController?.navigationBar.tintColor = settings.color.uiColor
        
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
        
        viewModel.incrementCliker()
        
    }

}


