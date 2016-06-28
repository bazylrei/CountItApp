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

/// View model of the settings functionality
public class SettingsViewModel: NSObject {
    
    /// A data storage to save model information
    let dataStorage : DataStorage = DataStorage()
    
    /// The watch session 
    let watchSession : WatchSessionManager = WatchSessionManager.sharedManager
    
    /// Key to be use in the application context dictionary
    public enum ApplicationContextKey: String{
        
        case SettingsKey = "settings"
        
    }
    
    /// Clicker model marked as dynamic for KVO 
    var settings: Settings = Settings()
    {
        didSet{
           //When the settings are update, update their observers
           updateObservers()
        }
    }
    
    /// A Replay subjeft to update teh settings
    public var settingsChangedSubject: ReplaySubject<Settings>
   
    /// Driver when the settings are change
    public var settingsChangedDriver : Driver<Settings>
    
    public override init(){
        
        //Create the replay subject
        settingsChangedSubject = ReplaySubject.create(bufferSize: 1)
        
        //Create teh driver from based on the notification senter observer
        settingsChangedDriver =  NSNotificationCenter.defaultCenter().rx_notification(SettingsViewModel.ApplicationContextKey.SettingsKey.rawValue, object: settings).map{
            
            return $0.object as! Settings
            
        }.asDriver(onErrorJustReturn: Settings())
        
        super.init()
        
        /**
        Get the latest settings information
        */
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
    public func setColor(color: ClickerColors){
        
        settings.color = color
        
        saveAndUpdate()
    }
    
    public func setIncrementsMultiple(value: Int){
        
        settings.incrementMultiplier = value
        
        saveAndUpdate()
    }
    
    /**
     Sets the invert color settings property
     
     - parameter value: if inverting colors or not
     */
    public func setInvertColors(value: Bool){
        
        settings.invertColors = value
        
        saveAndUpdate()
    }
    
    /**
     Save the settings to dataStorage and update the application context with the information of the settings
     */
    private func saveAndUpdate()
    {
        dataStorage.saveSettings(settings)
        
        
        self.updateObservers()
        
        watchSession.updateApplicationContext(withKey: ApplicationContextKey.SettingsKey.rawValue, content: settings.toDictionary())
    }
    
    /**
     Updates teh observer
     */
    private func updateObservers(){
        
        /**
        Update the subject
        */
        settingsChangedSubject.on(.Next(settings))
        
        /**
        Sends a notification
        */
        NSNotificationCenter.defaultCenter().postNotificationName(ApplicationContextKey.SettingsKey.rawValue, object: settings)
    }
    
    
    deinit{
        
        //Add view model to the datasource delegate so we get application context changes
        watchSession.removeDataSourceChangedDelegate(self)
        
    }
    
}

// MARK: - application context delegate extension
extension SettingsViewModel: ApplicationContextChangedDelegate{
    
    
    // MARK: DataSourceUpdatedDelegate
    public func applicationContextDidUpdate(applicationContext: [String : AnyObject]) {
        
        if let settingsDict = applicationContext[ApplicationContextKey.SettingsKey.rawValue] as? [String:AnyObject]{
            
            self.settings = Settings(dictionary : settingsDict)
            
            self.dataStorage.saveSettings(settings)
            
        }
    }
    
}





