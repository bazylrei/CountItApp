//
//  SettingsViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UITableViewController {
    
    
    @IBOutlet weak var colorLabel: UILabel!

    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var greenButton: UIButton!
    
    let buttonCornerRadius: CGFloat = 15
    
    let buttonBorderWidth: CGFloat = 1

    let viewModel: SettingsViewModel = SettingsViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shapeButton(self.yellowButton, withColor: ClickerColors.YellowColor.uiColor)
        
        shapeButton(self.blueButton, withColor: ClickerColors.BlueColor.uiColor)
        
        shapeButton(self.redButton, withColor: ClickerColors.RedColor.uiColor)
        
        shapeButton(self.greenButton, withColor: ClickerColors.GreenColor.uiColor)
        
        self.navigationController?.navigationBar.hidden = false
        
        viewModel.settingsChangedDriver.driveNext{ [weak self ]settings in
            
         //   self?.view.backgroundColor = settings.color.uiColor
            
//            self?.doneButtonItem.tintColor = settings.color.uiColor
            
            self?.navigationController?.navigationBar.tintColor = settings.color.uiColor
            
        }.addDisposableTo(disposeBag)
        
        viewModel.getLatestSettings()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    private func shapeButton(button : UIButton, withColor color:UIColor){
        
        button.layer.cornerRadius = buttonCornerRadius
        
        button.layer.borderWidth = buttonBorderWidth
        
        button.layer.borderColor = color.darkerColor().CGColor
        
        button.layer.backgroundColor = color.CGColor
        
        button.setTitle("", forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func yellowButtonTouched(sender: AnyObject) {
        
        viewModel.setColor(ClickerColors.YellowColor)
    }
    

    @IBAction func blueButtonTouched(sender: AnyObject) {
        
        viewModel.setColor(ClickerColors.BlueColor)
    }
    
    @IBAction func greenButtonTouched(sender: AnyObject) {
        
         viewModel.setColor(ClickerColors.GreenColor)
        
    }
    
    @IBAction func redButtonTouched(sender: AnyObject) {
        
         viewModel.setColor(ClickerColors.RedColor)
        
        
        
    }
    

}
