//
//  HasProtocols.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public protocol HasAPIKey {
    var apiKey: String { get }
}

public protocol HasAPIClient {
    var apiClient: APIClient { get }
}
