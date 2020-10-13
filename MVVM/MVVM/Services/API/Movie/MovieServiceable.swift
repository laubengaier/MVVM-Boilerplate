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
    - Returns: Single<[NowPlaying]>
     */
    func nowPlaying() -> Single<[Movie]>
}
