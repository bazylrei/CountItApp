//
//  XCTestCase.swift
//  ClickerApp
//
//  Created by Leo Picado on 6/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
  func visitSettingsScreen(app app: XCUIApplication) {
    guard !app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["settingIcon"].tap()
  }

  func visitMainScreen(app app: XCUIApplication) {
    guard app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["Count It"].tap()
  }

  func increaseCount(times times: Int = 1, app: XCUIApplication) {
    let incrementCountButton = app.buttons["incrementCount"]
    incrementCountButton.tapWithNumberOfTaps(UInt(times), numberOfTouches: 1)
  }

  func decreaseCount(times times: Int = 1, app: XCUIApplication) {
    let bottomToolbar = app.toolbars.elementBoundByIndex(0)
    let decreaseButton = bottomToolbar.buttons.elementBoundByIndex(1)
    decreaseButton.tapWithNumberOfTaps(UInt(times), numberOfTouches: 1)
  }

  func assertCurrentCount(equals equals: Int, app: XCUIApplication) {
    XCTAssertEqual(getCurrentCount(app: app), equals)
  }

  func getCurrentCount(app app: XCUIApplication) -> Int {
    return Int(app.staticTexts["currentCount"].label)!
  }

  func resetCount(app app: XCUIApplication) {
    visitMainScreen(app: app)

    guard getCurrentCount(app: app) != 0 else { return }

    let bottomToolbar = app.toolbars.elementBoundByIndex(0)
    let resetButton = bottomToolbar.buttons.elementBoundByIndex(0)

    resetButton.tap()

    let resetAlert = app.alerts["Count It"]
    let okayButton = resetAlert.buttons["Ok"]
    okayButton.tap()
  }

  func resetMultiplier(app app: XCUIApplication) {
    visitSettingsScreen(app: app)

    guard !app.staticTexts["Increment by 1"].exists else {
      visitMainScreen(app: app)
      return
    }

    while !app.staticTexts["Increment by 1"].exists {
      app.tables.buttons["Decrement"].tap()
    }
    
    visitMainScreen(app: app)
  }
}
