//
//  APIProvider.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation
import Moya

public protocol AuthorizedTargetType: TargetType {
    var needsAuth: Bool { get }
}

public protocol APIProvider: AuthorizedTargetType {}
