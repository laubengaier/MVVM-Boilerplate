//
//  MovieError.swift
//  MVVM
//
//  Created by Mario Zimmermann on 13.10.20.
//

import Foundation

public struct MovieError: Error, Codable {
    let message: String
    let success: Bool
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case success
        case statusCode = "status_code"
    }
}
