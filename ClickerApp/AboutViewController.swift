//
//  AboutViewController.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/17/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let versionNumber = VersionUtil.getAppVersion() {
            
            self.versionLabel.text = "Version \(versionNumber)"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
