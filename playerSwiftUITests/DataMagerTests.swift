//
//  DataMagerTest.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2023-08-24.
//

import XCTest
@testable import playerSwiftUI

// Protocol for a UserSettings-like object
protocol UserSettingsProtocol {
    var favorite: [String] { get set }
}

// Check if is or not
    class DataManagerTests: XCTestCase {

        func testManageDataForFavoriteData() {
            // Arrange
            let data = "TestItem"
            let userSettings = myUserSettings(favorite: ["TestItem", "AnotherItem"])
            let dataManager: myDataManager = YourDataManager()

            // Act
            let result = dataManager.manageData(data: data, userSettings: userSettings)

            // Assert
            XCTAssertTrue(result, "Expected data to be marked as favorite")
        }

        func testManageDataForNonFavoriteData() {
            // Arrange
            let data = "TestItem"
            let userSettings = myUserSettings(favorite: ["AnotherItem"])
            let dataManager: myDataManager = YourDataManager()

            // Act
            let result = dataManager.manageData(data: data, userSettings: userSettings)

            // Assert
            XCTAssertFalse(result, "Expected data not to be marked as favorite")
        }
        
        // Add more test cases as needed
        
    }
