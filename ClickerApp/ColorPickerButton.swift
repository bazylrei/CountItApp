//
//  ColorPickerButton.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/16/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit

/// Custom UI Button to pick colors
public class ColorPickerButton: UIButton {
    
    /// Radius of the button
    let buttonCornerRadius: CGFloat = 15
    
    /// Width of the border
    let buttonBorderWidth: CGFloat = 1
    
    /**
     Default initializer for the textfield done from storyboard
     
     - parameter coder: coder
     
     - returns:
     */
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
    }
    
    /**
     Setup the button with a color
     
     - parameter color: <#color description#>
     */
    public func setupWithColor(color: UIColor){
        
        layer.cornerRadius = buttonCornerRadius
        
        layer.borderWidth = buttonBorderWidth
        
        layer.borderColor = color.darkerColor().CGColor
        
        layer.backgroundColor = color.CGColor
        
        setTitle("", forState: UIControlState.Normal)
        
    }
    
}
