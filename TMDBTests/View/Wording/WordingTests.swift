//
//  WordingTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 30/07/22.
//

import XCTest
@testable import TMDB

class WordingTests: XCTestCase {

    private var sut: Wording!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_wording_hello() {
        self.sut = Wording(
            bundle: Bundle.main,
            local: Locale.current)
        
        let result = self.sut.str(.generalHello)
        
        XCTAssertEqual(result, "Halo")
    }
    
    func test_wording_welcome() {
        self.sut = Wording(
            bundle: Bundle.main,
            local: Locale.current)
        
        let result = self.sut.str(.generalWelcome)
        
        XCTAssertEqual(result, "Selamat Datang")
    }
}
