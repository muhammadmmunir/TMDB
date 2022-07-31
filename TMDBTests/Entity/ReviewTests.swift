//
//  ReviewTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import XCTest
@testable import TMDB

class ReviewTests: XCTestCase {

    private var sut: Review!
    private let defaultReview = Review(
        id: "2asd131",
        name: "name",
        avatarPath: "/avatar/path",
        content: "content")
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_initWithParamId() {
        self.sut = Review(id: "123das")
        
        XCTAssertEqual(self.sut.id, "123das")
        XCTAssertEqual(self.sut.name, nil)
        XCTAssertEqual(self.sut.avatarPath, nil)
        XCTAssertEqual(self.sut.content, nil)
    }
    
    func test_initWithAllParam() {
        self.sut = self.defaultReview
        
        XCTAssertEqual(self.sut.id, "2asd131")
        XCTAssertEqual(self.sut.name, "name")
        XCTAssertEqual(self.sut.avatarPath, "/avatar/path")
        XCTAssertEqual(self.sut.content, "content")
    }
    
    func test_avatarURL() {
        let expected = URL(string: APIConfig.baseImageURL + "w92" + "/avatar/path")
        
        self.sut = self.defaultReview
        
        XCTAssertEqual(self.sut.avatarURL, expected)
    }
}

