//
//  ViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clickerCountLabel: UILabel!
    
    @IBOutlet weak var clickerButton: UIButton!
    
    let clickerStorage: ClickerDataStorage = ClickerDataStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clickerCountLabel.text = String(clickerStorage.getClickerCount())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickerIncrementTouched(sender: AnyObject) {
        
        clickerStorage.incrementCount()
        
        self.clickerCountLabel.text = String(clickerStorage.getClickerCount())
        
    }

}

