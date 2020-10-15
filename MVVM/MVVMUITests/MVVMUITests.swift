//
//  MVVMUITests.swift
//  MVVMUITests
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import XCTest

class MVVMUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func testTabs() throws {
        let dashboard = app.staticTexts["Dashboard"]
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))
                
        let secondTab = app.tabBars.buttons.element(boundBy: 1)
        secondTab.tap()
        
        let actors = app.staticTexts["Actors"]
        XCTAssertTrue(actors.waitForExistence(timeout: 5))
        
        let firstTab = app.tabBars.buttons.firstMatch
        firstTab.tap()
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))
    }

    func testMovies() throws {
        let dashboard = app.staticTexts["Dashboard"]
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))
        
        let firstMovieCell = app.tables.cells.firstMatch
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 5))
        firstMovieCell.tap()
        
        let movieDetail = app.staticTexts["Detail"]
        XCTAssertTrue(movieDetail.waitForExistence(timeout: 5))
    }
    
    func testMovieDetails() {
        let dashboard = app.staticTexts["Dashboard"]
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))
        
        let firstMovieCell = app.tables.cells.firstMatch
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 5))
        firstMovieCell.tap()
        
        app.swipeUp()
        app.swipeDown()
        
        let movieTitle = app.staticTexts["Title"]
        XCTAssertTrue(movieTitle.waitForExistence(timeout: 5))
        
        let movieOverview = app.staticTexts["Overview"]
        XCTAssertTrue(movieOverview.waitForExistence(timeout: 5))
        
        // move back
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(dashboard.waitForExistence(timeout: 5))
    }

}
