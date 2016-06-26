//
//  MainScreenTests.swift
//  ClickerApp
//
//  Created by Chris Jimenez on 3/25/16.
//  Copyright © 2016 greenpixels. All rights reserved.
//

import XCTest

class MainScreenTests: XCTestCase {
  var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
    resetMultiplier(app: app)
    resetCount(app: app)
  }

  func testReset() {
    increaseCount(times: 1, app: app)
    resetCount(app: app)

    assertCurrentCount(equals: 0, app: app)
  }

  func testIncrementClicker() {
    increaseCount(times: 1, app: app)

    assertCurrentCount(equals: 1, app: app)
  }

  func testDecrementClicker() {
    increaseCount(times: 2, app: app)
    decreaseCount(times: 1, app: app)

    assertCurrentCount(equals: 1, app: app)
  }
}
