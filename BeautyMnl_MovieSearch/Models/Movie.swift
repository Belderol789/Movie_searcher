//
//  Movie.swift
//  BeautyMnl_MovieSearch
//
//  Created by iOSDev on 3/24/21.
//

import Foundation

struct MovieResults: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String

    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
