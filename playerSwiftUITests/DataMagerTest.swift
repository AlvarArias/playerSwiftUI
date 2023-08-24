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


class CheckFavoriteCTests: XCTestCase {

    var checkFavoriteCInstance: checkFavoriteC!
    var userSettingsMock: UserSettingsMock!
    
    override func setUpWithError() throws {
            userSettingsMock = UserSettingsMock()
          //  checkFavoriteCInstance = checkFavoriteC(userSettings: userSettingsMock)
        }


    override func tearDownWithError() throws {
        checkFavoriteCInstance = nil
        userSettingsMock = nil
    }

    func testManageData_IsFavorite() {
        // Set up any required dependencies or mocks
        
        // Mock UserSettings behavior
        userSettingsMock.favorite = ["favorite1", "favorite2", "favorite3"]
        
        // Perform the test
        //XCTAssertTrue(checkFavoriteCInstance.manageData(data: "favorite2"))
      
    }
    
    func testManageData_NotFavorite() {
        // Set up any required dependencies or mocks
        
        // Mock UserSettings behavior
        userSettingsMock.favorite = ["favorite1", "favorite3"]
        
        // Perform the test
        //XCTAssertFalse(checkFavoriteCInstance.manageData(data: "favorite2"))
    }
    
    // Add more test cases as needed

}

// Mock UserSettings
class UserSettingsMock: UserSettingsProtocol {
    var favorite: [String] = ["favorite1", "favorite2", "favorite3"]
    // Override or add necessary properties/methods for testing
}
