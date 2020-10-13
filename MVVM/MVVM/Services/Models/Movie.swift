//
//  Movie.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation

struct Movie : Codable {
    
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(title: String, overview: String) {
        self.id = 1
        self.title = title
        self.posterPath = nil
        self.backdropPath = nil
        self.voteAverage = nil
        self.overview = overview
        self.releaseDate = nil
        
    }
    
}
