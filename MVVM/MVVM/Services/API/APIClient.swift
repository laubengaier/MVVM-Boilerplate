//
//  APIClient.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import Moya
import RxSwift

public class APIClient {
    
    let apiKey: String
    
    init(apiKey: String){
        self.apiKey = apiKey
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
    
    func handlePossibleErrors<T>(response: Response, errorType: T.Type) -> Observable<Response> where T: Error, T: Codable {
        guard 200...299 ~= response.statusCode else {
            do {
                let errorResponse = try response.map(errorType)
                return .error(errorResponse)
            } catch {
                return .error(error)
            }
        }
        return .just(response)
    }
    
    private func createEndpointClosure<T: APIProvider>(for target: T.Type) -> MoyaProvider<T>.EndpointClosure {
        let endpointClosure = { (target: T) -> Endpoint in
            let apiKeyQuery: String = "?api_key=\(self.apiKey)"
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
        let requestClosure = { [weak self] (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) -> Void in
            guard let request = try? endpoint.urlRequest() else {
                done(.failure(MoyaError.requestMapping(endpoint.url)))
                return
            }
            done(.success(request))
            // do what ever you want (e.g.: check token)
        }
        return requestClosure
    }
    
}
