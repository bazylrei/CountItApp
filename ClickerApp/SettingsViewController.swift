//
//  SettingsViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var colorLabel: UILabel!

    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var greenButton: UIButton!
    
    let buttonCornerRadius: CGFloat = 25
    
    let buttonBorderWidth: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shapeButton(self.yellowButton)
        
        shapeButton(self.blueButton)
        
        shapeButton(self.redButton)
        
        shapeButton(self.greenButton)
    
        
        // Do any additional setup after loading the view.
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
    }
    

    @IBAction func blueButtonTouched(sender: AnyObject) {
    }
    
    @IBAction func greenButtonTouched(sender: AnyObject) {
    }
    
    @IBAction func redButtonTouched(sender: AnyObject) {
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
