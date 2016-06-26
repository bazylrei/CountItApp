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
  func tap(button button: XCUIElement, times: Int = 1) {
    for _ in 1...times {
      button.tap()
    }
  }

  func visitSettingsScreen(app app: XCUIApplication) {
    guard !app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["settingIcon"].tap()
  }

  func visitMainScreen(app app: XCUIApplication) {
    guard app.navigationBars["Settings"].exists else { return }

    app.navigationBars.buttons["Count It"].tap()
  }
}
