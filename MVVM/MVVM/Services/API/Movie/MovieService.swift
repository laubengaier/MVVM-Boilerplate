//
//  MovieService.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import RxMoya
import Moya
import RxSwift
import RxCocoa

enum MovieProvider {
    case nowPlaying
}

extension MovieProvider: APIProvider {
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/")! }
    
    var needsAuth: Bool { return false }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .nowPlaying: return .requestParameters(parameters: ["language": "de-DE"], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .nowPlaying: return Data()
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}


public class MovieService: MovieServicable {
    
    typealias Dependencies = HasAPIClient
    
    let dependencies: Dependencies
    
    let movieProvider: MoyaProvider<MovieProvider>
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        self.movieProvider = self.dependencies.apiClient.createProvider(for: MovieProvider.self)
    }
    
    public func nowPlaying() -> Single<[Movie]> {
        let request = self.movieProvider.rx.request(.nowPlaying)
        
        return request
        .asObservable()
        .flatMap { (response) -> Observable<Response> in
            guard 200...299 ~= response.statusCode else {
                do {
                    print("Error happened while fetching Now Playing")
                    let errorResponse = try response.map(MovieError.self)
                    throw errorResponse
                } catch {
                    throw error
                }
            }
            return .just(response)
        }
        .map(MovieResultWrapper.self)
        .map({ $0.results })
        .asSingle()
    }
    
}
