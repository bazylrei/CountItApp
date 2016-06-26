//
//  SettingsScreenTests.swift
//  ClickerApp
//
//  Created by Leo Picado on 6/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import Foundation
import XCTest

class SettingScreenTests: XCTestCase {
  var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
  }

  func testBasicUI() {
    resetMultiplier(app: app)
    visitSettingsScreen(app: app)
    XCTAssertTrue(app.tables.cells.staticTexts["Increment by 1"].exists)
    XCTAssertTrue(app.tables.cells.staticTexts["Color"].exists)
    ["redButton", "blueButton", "greenButton", "yellowButton"].forEach { identifier in
      XCTAssertTrue(app.buttons[identifier].exists)
    }
    XCTAssertTrue(app.tables.cells.staticTexts["Apple Watch Help"].exists)
    XCTAssertTrue(app.tables.cells.staticTexts["Rate"].exists)
    XCTAssertTrue(app.tables.cells.staticTexts["Follow me on Twitter"].exists)
    XCTAssertTrue(app.tables.cells.staticTexts["Github project page"].exists)
    XCTAssertTrue(app.tables.cells.staticTexts["About"].exists)
  }

  func testChangeMultiplier() {
    resetMultiplier(app: app)
    resetCount(app: app)

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

  func testChangeColor() {
    visitSettingsScreen(app: app)

    let yellowButton = app.buttons["yellowButton"]
    yellowButton.tap()

    XCTAssertTrue(yellowButton.selected)

    let blueButton = app.buttons["blueButton"]
    blueButton.tap()
    
    XCTAssertTrue(blueButton.selected)
    XCTAssertFalse(yellowButton.selected)
  }

}
