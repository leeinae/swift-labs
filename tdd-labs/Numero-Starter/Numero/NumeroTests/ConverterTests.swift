//
//  ConverterTests.swift
//  NumeroTests
//
//  Created by 이인애 on 2022/04/18.
//  Copyright © 2022 Facebook. All rights reserved.
//

import XCTest
@testable import Numero /// import해서 Numero의 클래스, 메소드에 access

class ConverterTests: XCTestCase {
    let converter = Converter()
    
    func testConversionForOne() {
        let result = converter.convert(1)
        /// check the expected conversion result (RED -> GREEN)
        XCTAssertEqual(result, "I", "Conversion for 1 is incorrect")
    }
    
    func testConversionForTwo() {
        let result = converter.convert(2)
        
        XCTAssertEqual(result, "II", "Conversion for 2 is incorrect")
    }
    
    func testConversionForThree() {
        let result = converter.convert(3)

        XCTAssertEqual(result, "III", "Conversion for 3 is incorrect")
    }
    
    func testConversionForFour() {
      let result = converter.convert(4)
      XCTAssertEqual(result, "IV", "Conversion for 4 is incorrect")
    }

    
    func testConversionForFive() {
        let result = converter.convert(5)
        
        XCTAssertEqual(result, "V", "Conversion for 5 is incorrect")
    }
    
    func testConversionForNine() {
      let result = converter.convert(9)
      XCTAssertEqual(result, "IX", "Conversion for 9 is incorrect")
    }
    
    func testConversionForTwenty() {
      let result = converter.convert(20)
      XCTAssertEqual(result, "XX", "Conversion for 20 is incorrect")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
