//
//  Movie.swift
//  MovieCompanion
//
//  Created by Tyler on 4/23/23.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id = UUID().uuidString
    var Title: String
    var Year: String
    var Rated: String
    var Released: String
    var Runtime: String
    var Genre: String
    var Director: String
    var Actors: String
    var Country: String
    var Awards: String
    var Poster: String
    var Metascore: String
    var imdbRating: String
    var BoxOffice: String
    
    enum CodingKeys: CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Actors, Country, Awards, Poster, Metascore, imdbRating, BoxOffice
    }
}
