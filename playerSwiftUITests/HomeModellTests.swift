//
//  HomeModell.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2023-08-25.
//

import XCTest
@testable import playerSwiftUI

final class HomeModellTests: XCTestCase {
    
    func testLoadStation() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "radios23", withExtension: "json") else {
            XCTFail("Could not find JSON file in the test bundle")
            return
        }
        
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let expectedStations = try! decoder.decode([radioStationInfo].self, from: data)
        
        let loadRadioStationJSONFile = LoadRadioStationJSONFile()
        //loadRadioStationJSONFile.loadStation()
        
        XCTAssertEqual(loadRadioStationJSONFile.radioStations, expectedStations, "Loaded radio stations do not match the expected ones")
    }
    
    
    func testLoadStation2() {
            // Create an instance of LoadRadioStationJSONFile
            let loadRadioStationJSONFile = LoadRadioStationJSONFile()

            // Load radio stations using the method
            let loadedStations = loadRadioStationJSONFile.loadStation()

            // Assert that loadedStations is not empty
            XCTAssertFalse(loadedStations.isEmpty, "Loaded radio stations should not be empty")

            // Add additional assertions if needed, such as verifying the count or content of loadedStations
            XCTAssertEqual(loadedStations.count, 52, "Loaded radio stations count should match the expected count")
        }
}

