//
//  Movie.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

// MARK: - Movie
struct Movie: Codable {
    let search: [Search]?
    let totalResults: String?
    let response: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
