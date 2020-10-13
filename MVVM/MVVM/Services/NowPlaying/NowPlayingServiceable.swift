//
//  NowPlayingServiceable.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import RxSwift

public protocol NowPlayingServicable {
    /**
     Get a list of movies in theatres.
    - Returns: Single<[NowPlaying]>
     */
    func nowPlaying() -> Single<Any>
}
