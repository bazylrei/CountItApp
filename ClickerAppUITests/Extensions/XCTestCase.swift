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
  /**
   Takes user to the Settings screen, in case it wasn't there.

   - parameter app: current app
   */
  func visitSettingsScreen(app app: XCUIApplication) {
    guard !app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["settingIcon"].tap()
  }

  /**
   Takes user to the Main screen, in case it wasn't there.

   - parameter app: current app
   */
  func visitMainScreen(app app: XCUIApplication) {
    guard app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["Count It"].tap()
  }

  /**
   Increases the current count of the clicker.

   - parameter times:      how many times the clicker should be incremented
   - parameter app:        current app
   - parameter byTapping:  interaction to be used
   */
  func increaseCount(times times: Int = 1, app: XCUIApplication, byTapping: Bool = true) {
    if byTapping {
      let incrementCountButton = app.buttons["incrementCount"]
      incrementCountButton.tapWithNumberOfTaps(UInt(times), numberOfTouches: 1)
    } else {
      for _ in 1...times {
        app.windows.elementBoundByIndex(0).swipeUp()
      }
    }
  }

  /**
   Decreases the current count of the clicker.

   - parameter times:      how many times the clicker should be decrementd
   - parameter app:        current app
   - parameter byTapping:  interaction to be used
   */
  func decreaseCount(times times: Int = 1, app: XCUIApplication, byTapping: Bool = true) {
    if byTapping {
      let bottomToolbar = app.toolbars.elementBoundByIndex(0)
      let decreaseButton = bottomToolbar.buttons.elementBoundByIndex(1)
      decreaseButton.tapWithNumberOfTaps(UInt(times), numberOfTouches: 1)
    } else {
      for _ in 1...times {
        app.windows.elementBoundByIndex(0).swipeDown()
      }
    }
  }

  /**
   Asserts the current clicker count value.

   - parameter equals: expectation
   - parameter app:    current app
   */
  func assertCurrentCount(equals equals: Int, app: XCUIApplication) {
    XCTAssertEqual(getCurrentCount(app: app), equals)
  }

  /**
   Restores the current clicker count back to zero, in case it wasn't at zero yet.

   - parameter app: current app
   */
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

  /**
   Resets the multiplier to steps of 1, in case it wasn't there yet.

   - parameter app: current app
   */
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

  /**
   Retrieves the current clicker count.

   - parameter app: current app

   - returns: Casted Int of current count
   */
  private func getCurrentCount(app app: XCUIApplication) -> Int {
    return Int(app.staticTexts["currentCount"].label)!
  }
}
