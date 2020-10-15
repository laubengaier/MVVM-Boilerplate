//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import XCTest
import Quick
import Nimble
@testable import MVVM

class MVVMTests: QuickSpec {
    
    override func spec() {
        describe("MathTests") {
            
            context("first") {
                it("simple mathz") {
                    expect(1+1).to(equal(2))
                }
            }
            
            context("second") {
                it("simple maths") {
                    expect(1+1).to(equal(2))
                }
            }
            
        }
    }
    
}
