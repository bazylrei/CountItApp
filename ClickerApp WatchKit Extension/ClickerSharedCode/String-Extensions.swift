//
//  String-Extensions.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/16/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

// MARK: - String extensions
extension String{
    
    /// Returns the localized string value
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
    
}