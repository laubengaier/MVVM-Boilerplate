//
//  APIClient.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import Moya



final class APIClient {
    
    typealias Dependencies = HasAPIKey
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    func createProvider<T: APIProvider>(for target: T.Type) -> MoyaProvider<T> {
        let endpointClosure = self.createEndpointClosure(for: target)
        let requestClosure = self.createRequestClosure(for: target)
        
        let tokenPlugin = AuthPlugin { () -> String? in
            return "{ insert access token here }"
        }
        
        // You can add more plugins
        let plugins = [tokenPlugin]
        
        return MoyaProvider<T>(endpointClosure: endpointClosure,
                               requestClosure: requestClosure,
                               plugins: plugins)
    }
    
    private func createEndpointClosure<T: APIProvider>(for target: T.Type) -> MoyaProvider<T>.EndpointClosure {
        let endpointClosure = { (target: T) -> Endpoint in
            let apiKeyQuery: String = "?api_key=\(self.dependencies.apiKey)"
            let endpoint = Endpoint(url: target.baseURL.absoluteString.appending(target.path + apiKeyQuery),
                             sampleResponseClosure: { return EndpointSampleResponse.networkResponse(200, target.sampleData)},
                             method: target.method,
                             task: target.task,
                             httpHeaderFields: ["Content-Type": "application/json"])
            return endpoint
        }
        return endpointClosure
    }
    
    private func createRequestClosure<T: APIProvider>(for target: T.Type) -> MoyaProvider<T>.RequestClosure {
        let requestClosure = { [weak self] (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) -> Void in
            // do what ever you want (e.g.: check token)
        }
        return requestClosure
    }
    
}
