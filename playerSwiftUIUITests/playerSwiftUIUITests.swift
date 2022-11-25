//
//  playerSwiftUIUITests.swift
//  playerSwiftUIUITests
//
//  Created by Alvar Arias on 2022-11-21.
//

import XCTest

class playerSwiftUIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    
        let welcome = app.staticTexts.element.firstMatch
        let radio = app.staticTexts.element(boundBy: 2)
        
      
        XCTAssert(welcome.exists)
        XCTAssertEqual(welcome.label, "Welcome")
        
         
        XCTAssertTrue(radio.waitForExistence(timeout: 15))
        
        XCTAssertEqual(radio.label, "Select your radio")

        
    }
    
    
    
   
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
