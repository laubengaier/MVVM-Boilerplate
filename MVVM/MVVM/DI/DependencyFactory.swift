//
//  DependencyFactory.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public protocol DependencyFactoryProtocol {
    /**
     Creates each and every dependency we need in our project
    - Parameter window:Backdrop for the app's UI
    - Returns: AppDependencies
     */
    func create() -> AppDependencies
}

public class DependencyFactory: DependencyFactoryProtocol {
    
    public init(){}
    
    public func create() -> AppDependencies {
        
        let apiKey: String = self.makeAPIKey()
        
        let apiClient: APIClient = self.makeAPIClient(apiKey: apiKey)
        
        let movieService: MovieServicable = self.makeMovieService(apiClient: apiClient)
        
        return AppDependencies(apiKey: apiKey,
                               apiClient: apiClient,
                               movieService: movieService)
        
    }
    
    private func makeAPIKey() -> String {
        let ret: String = "4c0b8d236e387a7c24bc97ca0b0ecf03"
        return ret
    }
    
    private func makeAPIClient(apiKey: String) -> APIClient {
        let ret: APIClient = APIClient(apiKey: apiKey)
        return ret
    }
    
    private func makeMovieService(apiClient: APIClient) -> MovieServicable {
        let ret: MovieServicable = MovieService(apiClient: apiClient)
        return ret
    }
}
