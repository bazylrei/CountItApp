//
//  ClickerTests.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import XCTest

class ClickerTests: XCTestCase {
  var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
    resetMultiplier()
    resetCount()
  }

  func testSetMultiplierSettings() {
    visitSettingsScreen(app: app)
    XCTAssertTrue(app.navigationBars["Settings"].exists)

    app.tables.buttons["Increment"].tap()

    visitMainScreen(app: app)
    XCTAssertTrue(app.navigationBars["Count It"].exists)

    increaseCount(times: 1)
    assertCurrentCount(equals: 2)

    visitSettingsScreen(app: app)
    XCTAssert(app.staticTexts["Increment by 2"].exists)
  }

  func testReset() {
    increaseCount(times: 1)
    resetCount()

    assertCurrentCount(equals: 0)
  }

  func testIncrementClicker() {
    increaseCount(times: 1)

    assertCurrentCount(equals: 1)
  }

  func testDecrementClicker() {
    increaseCount(times: 2)
    decreaseCount(times: 1)

    assertCurrentCount(equals: 1)
  }

  private func increaseCount(times times: Int = 1) {
    let incrementCountButton = app.buttons["incrementCount"]
    tap(button: incrementCountButton, times: times)
  }

  private func decreaseCount(times times: Int = 1) {
    let bottomToolbar = app.toolbars.elementBoundByIndex(0)
    let decreaseButton = bottomToolbar.buttons.elementBoundByIndex(1)
    tap(button: decreaseButton, times: times)
  }

  private func assertCurrentCount(equals equals: Int) {
    XCTAssertEqual(getCurrentCount(), equals)
  }

  private func getCurrentCount() -> Int {
    return Int(app.staticTexts["currentCount"].label)!
  }

  private func resetCount() {
    visitMainScreen(app: app)

    guard getCurrentCount() != 0 else { return }

    let bottomToolbar = app.toolbars.elementBoundByIndex(0)
    let resetButton = bottomToolbar.buttons.elementBoundByIndex(0)

    resetButton.tap()

    let resetAlert = app.alerts["Count It"]
    let okayButton = resetAlert.buttons["Ok"]
    okayButton.tap()
  }

  private func resetMultiplier() {
    visitSettingsScreen(app: app)

    guard !app.staticTexts["Increment by 1"].exists else {
      visitMainScreen(app: app)
      return
    }

    while !app.staticTexts["Increment by 1"].exists {
      tap(button: app.tables.buttons["Decrement"])
    }

    visitMainScreen(app: app)
  }
}
