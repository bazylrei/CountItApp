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

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var doneButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var colorLabel: UILabel!

    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var greenButton: UIButton!
    
    let buttonCornerRadius: CGFloat = 30
    
    let buttonBorderWidth: CGFloat = 1
    
    let viewModel: SettingsViewModel = SettingsViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shapeButton(self.yellowButton)
        
        shapeButton(self.blueButton)
        
        shapeButton(self.redButton)
        
        shapeButton(self.greenButton)
        
        viewModel.settingsChangedDriver.driveNext{ [weak self ]settings in
            
            self?.view.backgroundColor = settings.color.uiColor
            
            self?.doneButtonItem.tintColor = settings.color.uiColor
            
            self?.navigationController?.navigationBar.tintColor = settings.color.uiColor
            
        }.addDisposableTo(disposeBag)
        
        viewModel.getLatestSettings()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    private func shapeButton(button : UIView){
        
        button.layer.cornerRadius = buttonCornerRadius
        
        button.layer.borderWidth = buttonBorderWidth
        
        button.layer.shadowColor = UIColor.blackColor().CGColor
        
        button.layer.shadowOpacity = 0.8
        
        button.layer.shadowRadius = 0.3
        
        button.layer.shadowOffset = CGSizeMake(1.5, 1.5)
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
    
    @IBAction func acceptTouched(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
