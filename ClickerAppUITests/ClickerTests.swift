//
//  ClickerTests.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import XCTest

class ClickerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        /**
         Give focus to the current view
         Dont know why I have to do thi
         
         - returns: <#return value description#>
         */
        XCUIApplication().otherElements.containingType(.NavigationBar, identifier:"Clicker").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetMultiplierSettings(){
        
        let app = XCUIApplication()
        app.navigationBars["Clicker"].buttons["settingIcon"].tap()
        
        let tablesQuery = app.tables
        let incrementButton = tablesQuery.buttons["Increment"]
        incrementButton.tap()
        let decrementButton = tablesQuery.buttons["Decrement"]
        decrementButton.tap()
        
        XCTAssert(app.staticTexts["Increment by 5"].exists)
        
        
       
    }

    func testResetClicker(){
        
        let app = XCUIApplication()
        app.toolbars.buttons["ic clear 36pt"].tap()
        app.alerts["Clicker"].collectionViews.buttons["Ok"].tap()
        
        XCTAssert(app.staticTexts["0"].exists)
        
    }
    
    func testIncrementClicker(){
        
        testResetClicker()
        
        let app = XCUIApplication()
        XCUIApplication().buttons["incrementCount"].tap()
        XCTAssert(app.staticTexts["5"].exists)
        
    }
    
    
    func testDecrementClicker(){
        
        testResetClicker()
        
        
        let app = XCUIApplication()
        app.toolbars.buttons["ic remove 36pt"].tap()
        app.buttons["incrementCount"].tap()
        XCTAssert(app.staticTexts["0"].exists)
        
    }
    
    

}
