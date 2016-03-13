//
//  InterfaceController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import RxSwift


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet var clickerCountLabel: WKInterfaceLabel!
    
    @IBOutlet var clickerCountButton: WKInterfaceButton!
    
    var disposeBag = DisposeBag()
    
    var viewModel: ClickerViewModel = ClickerViewModel()
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        viewModel.clickerCountDriver?
                    .map { String($0) }
                    .driveNext{ [weak self] count in
                        self?.clickerCountLabel.setText(count)
                    }.addDisposableTo(disposeBag)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        viewModel.updateToLatestClicker()

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func clickedAddTouched() {
        
        viewModel.incrementCliker()
        
    }
    

}

