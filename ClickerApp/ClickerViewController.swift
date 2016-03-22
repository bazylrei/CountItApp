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
        
        /**
        *  Observe clicker model, map it to String and update Label with animation
        */
        viewModel.clickerCountDriver?
            .map { String($0) }
            .driveNext{ [weak self] count in
                
             self?.updateCountLabelWithAnimation(count)
                
            }.addDisposableTo(disposeBag)

        
        
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
    
    private func updateCountLabelWithAnimation(count: String){
        
        
        //Define the shink and grow duration based on the duration parameter
        let shrinkDuration: NSTimeInterval = 0.20
        
        //Plays the shrink animation
        UIView.animateWithDuration(shrinkDuration, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            //Shrinks the image
            let scaleTransform: CGAffineTransform = CGAffineTransformMakeScale(1.25,1.25)
            self.clickerCountLabel.transform = scaleTransform
            self.clickerCountLabel.text = count
            
            //When animation completes, grow
            }, completion: { finished in
                
                
                //Plays the shrink animation
                UIView.animateWithDuration(shrinkDuration, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    //Shrinks the image
                    let scaleTransform: CGAffineTransform = CGAffineTransformMakeScale(1,1)
                    self.clickerCountLabel.transform = scaleTransform
                    
                    //When animation completes, grow the image
                    }, completion: { finished in
                        
                        
                })
                
                
        })
    }
    

    @IBAction func resetClickerTouched(sender: AnyObject) {
        
        
        let alertController = AlertControllerBuilder.buildOkCancelAlertWithTitle("app_name".localized, message: "reset_message".localized){ [weak self] Void in
            
            self?.viewModel.resetClicker()
        }
       
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
}


