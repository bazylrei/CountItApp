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
    

    @IBOutlet weak var yellowButton: ColorPickerButton!
    
    @IBOutlet weak var blueButton: ColorPickerButton!
    
    @IBOutlet weak var redButton: ColorPickerButton!
    
    @IBOutlet weak var greenButton: ColorPickerButton!
    
    @IBOutlet weak var incrementStepper: UIStepper!
    
    @IBOutlet weak var invertColorSwitch: UISwitch!
    
    @IBOutlet weak var incrementLabel: UILabel!

    let viewModel: SettingsViewModel = SettingsViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.setupObservers()
        
        viewModel.getLatestSettings()
        
        // Do any additional setup after loading the view.
    }
    
    /**
     Setups the UI with the different colors
     */
    func setupUI(){
        
        self.yellowButton.setupWithColor(ClickerColors.YellowColor.uiColor)
        
        self.blueButton.setupWithColor(ClickerColors.BlueColor.uiColor)
        
        self.redButton.setupWithColor(ClickerColors.RedColor.uiColor)
        
        self.greenButton.setupWithColor(ClickerColors.GreenColor.uiColor)

    }
    
    /**
     Setup the observers
     */
    func setupObservers(){
        
        /**
        *  If the settings is change update the color
        */
        viewModel.settingsChangedDriver.driveNext{ [weak self ]settings in
            
            self?.incrementStepper.tintColor = settings.color.uiColor.darkerColor()
            self?.invertColorSwitch.onTintColor = settings.color.uiColor
            
            }.addDisposableTo(disposeBag)
        
        /**
        *  If the settings is change, map the multiplier to a double and set that to the value of the stepper
        */
        viewModel.settingsChangedDriver.map{
            
            return Double($0.incrementMultiplier)
            
            }.drive(incrementStepper.rx_value)
            .addDisposableTo(disposeBag)
        
        /**
         *  If the settings are change, map the value to the invert color switch
         */
        viewModel.settingsChangedDriver.map{
            
            return Bool($0.invertColors)
            
        }.drive(invertColorSwitch.rx_value)
        .addDisposableTo(disposeBag)
        
        
        /**
        *  If the settings are change map the multiplier to an string and set that to the value of the label
        */
        viewModel.settingsChangedDriver.map{
            
            return "\("increment_text".localized) \($0.incrementMultiplier)"
            
            }.drive(incrementLabel.rx_text)
            .addDisposableTo(disposeBag)
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
    
    @IBAction func stepperChanged(sender: UIStepper) {
        
        viewModel.setIncrementsMultiple(Int(sender.value))
    }
    
    
    /**
     When the switch is changed
     
     - parameter sender: <#sender description#>
     */
    @IBAction func invertColorChanged(sender: UISwitch) {
        //TODO: Change this event to RX instead
        
        viewModel.setInvertColors(sender.on)
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section, indexPath.row)
        {
        case(1,1):
            self.rateApp()
            
        case(1,2):
            self.showTwitter()
            
        case(1,3):
            self.showGithub()
            
        default:
            break
            
        }
    }
    
    
    private func rateApp(){
        
        UIApplication.sharedApplication().openURL(NSURL(string: Constants.iTunesURL)!)
        
    }
    
    /**
     Opens the twitter app link
     */
    private func showTwitter(){
        
        UIApplication.sharedApplication().openURL(NSURL(string: Constants.twitterURL)!)
    }
    
    /**
     Opens the github app link
     */
    private func showGithub(){
        
        UIApplication.sharedApplication().openURL(NSURL(string: Constants.githubURL)!)
    }
    
    

}
