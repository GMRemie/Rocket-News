//
//  Rocket_NewsTests.swift
//  Rocket NewsTests
//
//  Created by Joseph Storer on 6/7/21.
//

import XCTest

class Rocket_NewsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    
    //MARK:: News View Model
    
    // Test to see if the network request is working with combine and returning data.
    func testNetworkRequest() {
        let dataModel = NewsViewModel()
        
        dataModel.reloadTableView = {
            XCTAssertNotNil(dataModel.articles)
            XCTAssert(dataModel.numberOfCells > 0)
        }
        
        dataModel.request()
    }
    
    
    // Make sure that only https articles are in the array after data is pulled. If http articles get thrown in, we'll run in to transport security errors.
    func testATSSort() {
        
        let dataModel = NewsViewModel()
        
        dataModel.reloadTableView = {
            XCTAssertNil(dataModel.articles.filter({!$0.url.contains("https:")}))
        }
        
        dataModel.request()
    }
    
    
    func testNumberOfCells() {
        let dataModel = NewsViewModel()
        
        dataModel.reloadTableView = {
            XCTAssertEqual(dataModel.articles.count, dataModel.numberOfCells)
        }
        
        dataModel.request()
    }
    
    func testCellReturn() {
        let dataModel = NewsViewModel()
        
        dataModel.reloadTableView = {
            let random = Int.random(in: 0..<dataModel.numberOfCells)
            XCTAssertEqual(dataModel.articles[random].id, dataModel.cellAtIndex(random).id)
        }
        
        dataModel.request()
    }
    func testReloadFuncCall(){
        let dataModel = NewsViewModel()
        
        dataModel.reloadTableView = {
            XCTAssertTrue(true)
        }
        
        dataModel.request()
    }
    

    
    //MARK:: Article Tests
    /*  ------------------- */

 
    
    
}
