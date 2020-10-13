//
//  Movie.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation

public struct Movie : Codable {
    
    let id: Int
    let title: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
}
