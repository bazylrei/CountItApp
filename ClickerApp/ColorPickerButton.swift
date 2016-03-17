//
//  ColorPickerButton.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/16/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

public class ColorPickerButton: UIButton {
    
    let buttonCornerRadius: CGFloat = 15
    
    let buttonBorderWidth: CGFloat = 1
    
    /**
     Default initializer for the textfield done from storyboard
     
     - parameter coder: coder
     
     - returns:
     */
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
    }
    
    public func setupWithColor(color: UIColor){
        
        layer.cornerRadius = buttonCornerRadius
        
        layer.borderWidth = buttonBorderWidth
        
        layer.borderColor = color.darkerColor().CGColor
        
        layer.backgroundColor = color.CGColor
        
        setTitle("", forState: UIControlState.Normal)
        
    }
    
}
