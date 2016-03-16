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

    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var greenButton: UIButton!
    
    @IBOutlet weak var incrementStepper: UIStepper!
    
    @IBOutlet weak var incrementLabel: UILabel!
    
    let buttonCornerRadius: CGFloat = 15
    
    let buttonBorderWidth: CGFloat = 1

    let viewModel: SettingsViewModel = SettingsViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.setupObservers()
        
        viewModel.getLatestSettings()
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        shapeButton(self.yellowButton, withColor: ClickerColors.YellowColor.uiColor)
        
        shapeButton(self.blueButton, withColor: ClickerColors.BlueColor.uiColor)
        
        shapeButton(self.redButton, withColor: ClickerColors.RedColor.uiColor)
        
        shapeButton(self.greenButton, withColor: ClickerColors.GreenColor.uiColor)
    }
    
    func setupObservers(){
        
        
        viewModel.settingsChangedDriver.driveNext{ [weak self ]settings in
            
            self?.navigationController?.navigationBar.tintColor = settings.color.uiColor
            
            self?.incrementStepper.tintColor = settings.color.uiColor.darkerColor()
            
            }.addDisposableTo(disposeBag)
        
        
        viewModel.settingsChangedDriver.map{
            
            return Double($0.incrementsMultiples)
            
            }.drive(incrementStepper.rx_value)
            .addDisposableTo(disposeBag)
        
        
        viewModel.settingsChangedDriver.map{
            
            return "Increment in multiples of : \($0.incrementsMultiples)"
            
            }.drive(incrementLabel.rx_text)
            .addDisposableTo(disposeBag)
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
    
    @IBAction func stepperChanged(sender: UIStepper) {
        
        viewModel.setIncrementsMultiple(Int(sender.value))
        
        
    }

}
