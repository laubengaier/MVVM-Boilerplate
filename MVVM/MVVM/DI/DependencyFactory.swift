//
//  DependencyFactory.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public class DependencyFactory: DependencyFactoryProtocol {
    
    public init(){}
    
    public func create() -> AppDependencies {
        
        let apiKey: String = self.makeAPIKey()
        
        let apiClient: APIClient = self.makeAPIClient(apiKey: apiKey)
        
        return AppDependencies(apiKey: apiKey,
                               apiClient: apiClient)
        
    }
    
    private func makeAPIKey() -> String {
        let ret: String = "4c0b8d236e387a7c24bc97ca0b0ecf03"
        return ret
    }
    
    private func makeAPIClient(apiKey: String) -> APIClient {
        let ret: APIClient = APIClient(apiKey: apiKey)
        return ret
    }
}
