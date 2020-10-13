//
//  GlobalAppDependencies.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public protocol GlobalAppDependencies: HasAPIClient &
                                       HasAPIKey {}

public struct AppDependencies: GlobalAppDependencies {
    public var apiKey: String
    public var apiClient: APIClient
}

public protocol DependencyFactoryProtocol {
    /**
     Creates each and every dependency we need in our project
    - Parameter window:Backdrop for the app's UI
    - Returns: AppDependencies
     */
    func create() -> AppDependencies
}

