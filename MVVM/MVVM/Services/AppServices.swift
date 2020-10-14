//
//  AppServices.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation

class AppServices: HasMovieService {
    
    typealias Dependencies = HasAPIClient

    private let dependencies: Dependencies
    
    let movieService: MovieServicable
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.movieService = MovieService(dependencies: dependencies)
    }
    
    deinit {
        print("deinit appservices")
    }
}
