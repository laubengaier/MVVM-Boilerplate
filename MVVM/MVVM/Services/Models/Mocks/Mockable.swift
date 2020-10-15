//
//  Mockable.swift
//  MVVM
//
//  Created by Mario Zimmermann on 15.10.20.
//

import Foundation

public protocol Mockable {
    static func sampleData() -> Data
}

extension Mockable {
    public static func sampleData() -> Data {
        if let url = Bundle.main.url(forResource: String(describing: self), withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
}
