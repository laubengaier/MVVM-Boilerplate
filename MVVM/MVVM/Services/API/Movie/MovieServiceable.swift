//
//  MovieServicable.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import RxSwift

public protocol MovieServicable {
    /**
     Get a list of movies in theatres.
    - Returns: Single<[Movie]>
     */
    func nowPlaying() -> Single<[Movie]>
    /**
     Search for movies.
     - Returns: Single<[Movie]>
     */
    func search(query: String) -> Single<[Movie]>
    /**
     Get the primary information about a movie.
     - Returns: Single<MovieDetail>
     */
    func details(for movieId: Int) -> Single<MovieDetail>
}
