//
//  DataMagerTests.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2023-08-24.
//

import XCTest
@testable import playerSwiftUI

final class DateTransformerTests: XCTestCase {

    var transformer: DateTransformer!

    override func setUp() {
        super.setUp()
        transformer = DateTransformer()
    }

    override func tearDown() {
        transformer = nil
        super.tearDown()
    }

    func testTransformDate_invalidString_returnsOriginalInput() {
        let input = "not-a-date"
        let result = transformer.transformDate(theProgramDate: input)
        XCTAssertEqual(result, input)
    }

    func testTransformDate_emptyString_returnsEmptyString() {
        let input = ""
        let result = transformer.transformDate(theProgramDate: input)
        XCTAssertEqual(result, input)
    }

    func testTransformDate_validISO8601_returnsFormattedString() {
        let input = "2024-06-15T14:30:00Z"
        let result = transformer.transformDate(theProgramDate: input)
        XCTAssertNotEqual(result, input, "A valid ISO 8601 date should be reformatted")
        XCTAssertTrue(result.contains("15"), "Formatted date should contain the day '15'")
    }

    func testTransformDate_validISO8601_doesNotContainT() {
        let input = "2024-06-15T14:30:00Z"
        let result = transformer.transformDate(theProgramDate: input)
        XCTAssertFalse(result.contains("T"), "Formatted date should not contain ISO 8601 'T' separator")
    }

    func testTransformDate_legacyAlias_worksIdentically() {
        let a = DateTransformer()
        let b = theDateFormater()
        let input = "2024-06-15T14:30:00Z"
        XCTAssertEqual(
            a.transformDate(theProgramDate: input),
            b.transformDate(theProgramDate: input)
        )
    }
}
