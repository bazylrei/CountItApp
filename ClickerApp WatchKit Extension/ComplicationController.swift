//
//  ComplicationController.swift
//  ClickerApp WatchKit Extension
//
//  Created by Christopher Jimenez on 3/8/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import ClockKit
import RxSwift


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    /// View model fot he clicker information
    var viewModel: ClickerViewModel = ClickerViewModel()
    
    /// View model to get the information of the settings
    var settingsViewModel: SettingsViewModel = SettingsViewModel()
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        //Gets the default place holder
        let complication = buildComplicationTemplateWithLatestUsingComplication(complication)
        //Creates a timeline entry to handle
        var entry: CLKComplicationTimelineEntry? =  nil
        
        if let complication = complication{
             entry  = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: complication)
        }
        //Handles the entry
        handler(entry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    /**
     Requested update for the complication
     */
    func requestedUpdateDidBegin() {
        
        let server=CLKComplicationServer.sharedInstance()
        
        
        for complication in server.activeComplications {
            server.reloadTimelineForComplication(complication)
        }
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        //Update every hour
        handler(NSDate(timeIntervalSinceNow: 60*60))
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        let complication = buildComplicationTemplateWithLatestUsingComplication(complication)
        
        handler(complication)
    }
    
    /**
     Builds the complication template using the complication
     
     - parameter complication: <#complication description#>
     
     - returns: <#return value description#>
     */
    func buildComplicationTemplateWithLatestUsingComplication(complication: CLKComplication) -> CLKComplicationTemplate?{
        
        /**
        Get latest information
        
        - returns: <#return value description#>
        */
        viewModel.updateToLatestClicker()
        
        /**
        Get the latest settings
        
        - returns: <#return value description#>
        */
        settingsViewModel.getLatestSettings()
        
        /// Creates the complication
        let complication = createTemplaceForComplication(complication, withClickerCount: viewModel.clicker.currentCount, andColor: settingsViewModel.settings.color.uiColor)
        
        return complication
        
    }

    /**
     Creates the template for the complication
     
     - parameter complication: Complication type to base de template
     - parameter clickerCount: The count to display
     - parameter color:        The color to set
     
     - returns: <#return value description#>
     */
    func createTemplaceForComplication(complication: CLKComplication, withClickerCount clickerCount: Int, andColor color:UIColor) -> CLKComplicationTemplate? {
        
        var complicationTemplate: CLKComplicationTemplate? = nil
        
        let clickerCountString = String(clickerCount)
        
        /**
        *  Check for the supported families
        */
        switch complication.family{
            
        case .ModularSmall:
            let modularSmall = CLKComplicationTemplateModularSmallStackText()
            modularSmall.line1TextProvider = CLKSimpleTextProvider(text: "+")
            modularSmall.line2TextProvider = CLKSimpleTextProvider(text: clickerCountString)
            complicationTemplate = modularSmall
            
        case .UtilitarianSmall:
            let smallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
            smallFlat.textProvider = CLKSimpleTextProvider(text: "+ \(clickerCountString)")
            complicationTemplate = smallFlat
            
        case .CircularSmall:
            let circularSmall = CLKComplicationTemplateCircularSmallStackText()
            circularSmall.line1TextProvider = CLKSimpleTextProvider(text: "+")
            circularSmall.line2TextProvider = CLKSimpleTextProvider(text: clickerCountString)
            complicationTemplate = circularSmall
            
        default:
            complicationTemplate = nil
        }
        
        if let complicationTemplate =  complicationTemplate {
            
            complicationTemplate.tintColor = color
        }
        
        return complicationTemplate
        
    }
    
}
