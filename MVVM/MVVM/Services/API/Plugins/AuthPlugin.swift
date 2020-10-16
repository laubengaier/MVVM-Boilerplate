//
//  AuthPlugin.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import Moya

/**
 You could use this plugin to make sure a Authorization header get's set whenever it's needed.
 */
struct AuthPlugin: PluginType {
    
    // Pass a function which returns the current valid access token.
    let tokenClosure: () -> String?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard
            let token = tokenClosure(),
            let target = target as? AuthorizedTargetType,
            target.needsAuth
        else {
            return request
    }
        
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
