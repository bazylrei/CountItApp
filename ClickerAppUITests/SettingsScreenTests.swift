//
//  SettingsScreenTests.swift
//  ClickerApp
//
//  Created by Leo Picado on 6/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import XCTest

class SettingSCreenTests: XCTestCase {
  var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
    resetMultiplier(app: app)
    resetCount(app: app)
  }

  func testSetMultiplierSettings() {
    visitSettingsScreen(app: app)
    XCTAssertTrue(app.navigationBars["Settings"].exists)

    app.tables.buttons["Increment"].tap()

    visitMainScreen(app: app)
    XCTAssertTrue(app.navigationBars["Count It"].exists)

    increaseCount(times: 1, app: app)
    assertCurrentCount(equals: 2, app: app)

    visitSettingsScreen(app: app)
    XCTAssert(app.staticTexts["Increment by 2"].exists)
  }
}
