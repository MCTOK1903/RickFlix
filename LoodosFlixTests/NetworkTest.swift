//
//  NetworkTest.swift
//  LoodosFlixTests
//
//  Created by Celal Tok on 14.05.2021.
//

import XCTest
@testable import LoodosFlix

class NetworkTest: XCTestCase {
    
    func parsingTest() throws {
        do {
            let bundle = Bundle(for: LoodosFlixTests.self)
            guard let url = bundle.url(forResource: "movie", withExtension: "json") else {
                XCTFail()
                return 
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let movie = try decoder.decode(Movie.self, from: data)
            
            XCTAssertEqual(movie.search?.first?.title, "The Green Mile")
            XCTAssertEqual(movie.search?.first?.year, "1999")
            XCTAssertEqual(movie.search?.first?.imdbID, "tt0120689")
            XCTAssertEqual(movie.search?.first?.type, "movie")
        } catch {
            XCTFail()
        }
    }
}
