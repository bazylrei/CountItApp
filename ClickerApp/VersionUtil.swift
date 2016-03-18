//
//  VersionUtil.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/17/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation

public class VersionUtil{
    
    
    public class func getAppVersion() -> String?{
        
        
        let versionObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        
        let version = versionObject as? String
        
        return version
        
    }
    
}
