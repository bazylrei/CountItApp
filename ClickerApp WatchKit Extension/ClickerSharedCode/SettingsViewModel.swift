//
//  SettingsViewModel.swift
//  ClickerApp
//
//  Created by Christopher Jimenez on 3/14/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class SettingsViewModel: NSObject {
    
    let dataStorage : DataStorage = DataStorage()
    
    let watchSession : WatchSessionManager = WatchSessionManager.sharedManager
    
    
    /// Key to be use in the application context dictionary
    enum ApplicationContextKey: String{
        
        case SettingsKey = "settings"
        
    }
    
    /// Clicker model marked as dynamic for KVO
    var settings: Settings = Settings()
//        {
//        didSet{
//            
//            clickerCount.value = clicker.currentCount
//            
//        }
//    }
    
//    var clickerCount =  Variable(0)
//    
//    
//    var clickerCountDriver: Driver<Int>?
//    
    
    public override init(){
        
        super.init()
        
//        clickerCountDriver = clickerCount.asDriver()
        
        getLatestSettings()
        
        //Add view model to the datasource delegate so we get application context changes
        watchSession.addDataSourceChangedDelegate(self)
        
    }
    
    /**
     Get the latest clicker from storage or applicationContext
     
     - returns: clicker
     */
    public func getLatestSettings()
    {
        
        //Ge the clicker from storage
        var settings: Settings = dataStorage.getSettings()
        
        /// Check if we have the settings dict in the application context
        if let settingsDict = watchSession.receivedApplicationContext?[ApplicationContextKey.SettingsKey.rawValue] as? [String : AnyObject]
        {
            //Get the settings object from the application Context
             settings = Settings(dictionary: settingsDict)
            
        }
        
        self.settings = settings
    }
    
    
    /**
     Increment the clicker count and update its datastorage and application context
     */
    public func setColor(color: UIColor){
        
        settings.color = color
        
        saveAndUpdate()
    }
    
    
    /**
     Save the settings to dataStorage and update the application context with the information of the settings
     */
    private func saveAndUpdate()
    {
//        clickerCount.value = clicker.currentCount
        
        dataStorage.saveSettings(settings)
        
        watchSession.updateApplicationContext(withKey: ApplicationContextKey.SettingsKey.rawValue, content: settings.toDictionary())
    }
    
    deinit{
        
        //Add view model to the datasource delegate so we get application context changes
        watchSession.removeDataSourceChangedDelegate(self)
        
    }
    
}

extension SettingsViewModel: ApplicationContextChangedDelegate{
    
    
    // MARK: DataSourceUpdatedDelegate
    public func applicationContextDidUpdate(applicationContext: [String : AnyObject]) {
        
        if let settingsDict = applicationContext[ApplicationContextKey.SettingsKey.rawValue] as? [String:AnyObject]{
            
            self.settings = Settings(dictionary : settingsDict)
            
        }
    }
    
}

