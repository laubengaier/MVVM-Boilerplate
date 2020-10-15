//
//  GlobalAppDependencies.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public protocol GlobalAppDependencies: HasAPIClient &
                                       HasAPIKey &
                                       HasMovieService {}

public struct AppDependencies: GlobalAppDependencies {
    public var apiKey: String
    public var apiClient: APIClient
    public var movieService: MovieServicable
}



