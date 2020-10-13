//
//  Movie.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit

public struct MovieResultWrapper : Codable {
    let results: [Movie]
}

public struct Movie : Codable {
    
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

extension Movie {
    var posterImage: UIImage? {
        guard
            let imageName = posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageName)"),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
        else {
            return nil
        }
        return image
    }
    var posterImageUrl: URL? {
        guard
            let imageName = posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageName)")
        else {
            return nil
        }
        return url
    }
}
