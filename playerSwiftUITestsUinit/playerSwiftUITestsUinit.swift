//
//  playerSwiftUITestsUinit.swift
//  playerSwiftUITestsUinit
//
//  Created by Alvar Arias on 2023-10-18.
//

import XCTest
@testable import playerSwiftUI


final class playerSwiftUITestsUinit: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
     
        //
        let myName = "Alvar"
        let myTest = mytest()
        
        
        //
        let myValidate = myTest.validate(name: myName)
        
        //
        XCTAssertFalse(myValidate)
        
    }


}
