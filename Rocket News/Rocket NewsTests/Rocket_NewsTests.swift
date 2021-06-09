//
//  Rocket_NewsTests.swift
//  Rocket NewsTests
//
//  Created by Joseph Storer on 6/7/21.
//

import XCTest
import CoreData
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
    

    
    //MARK:: CoreData Tests
    /*  ------------------- */

    // Test to see that article objects can be created from CoreData's Data.
    func testArticleCreation(){
        
        let coreDataTest = CoreDataTest()
        let random = Int.random(in: 1..<500)

        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: coreDataTest.managedObjectContext!)
        let articleObj = NSManagedObject(entity: entity!, insertInto: coreDataTest.managedObjectContext!)

        articleObj.setValue(random, forKey: "id")
        articleObj.setValue("New title! \(random)", forKey: "title")
        articleObj.setValue("summary", forKey: "summary")
        articleObj.setValue("datehere", forKey: "publishedAt")
        articleObj.setValue("https://www.google.com", forKey: "imageUrl")
        articleObj.setValue("https://www.google.com", forKey: "newsSite")
        articleObj.setValue(50.0, forKey: "progress")
        articleObj.setValue("https://www.google.com", forKey: "url")
        
        let article = Article(articleObj)
        
        XCTAssertEqual(article.id, random)
        XCTAssertEqual(50.0, article.progress)
        
    }
    // This test displays both saving and loading functionality.
    
    func testCoreDataSaving(){
        
        let coreDataTest = CoreDataTest()
        // Check to see if the db is empty
        XCTAssert(coreDataTest.coreDataHelper!.loadArticles().isEmpty)
        
        // Create dummy object
        let random = Int.random(in: 1..<500)

        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: coreDataTest.managedObjectContext!)
        let articleObj = NSManagedObject(entity: entity!, insertInto: coreDataTest.managedObjectContext!)

        articleObj.setValue(random, forKey: "id")
        articleObj.setValue("New title! \(random)", forKey: "title")
        articleObj.setValue("summary", forKey: "summary")
        articleObj.setValue("datehere", forKey: "publishedAt")
        articleObj.setValue("https://www.google.com", forKey: "imageUrl")
        articleObj.setValue("https://www.google.com", forKey: "newsSite")
        articleObj.setValue(50.0, forKey: "progress")
        articleObj.setValue("https://www.google.com", forKey: "url")
        
        let article = Article(articleObj)
        
        // Save Dummy object
        
        coreDataTest.coreDataHelper!.attemptUpdate(article)
        
        // See if it exists
        
        XCTAssertFalse(coreDataTest.coreDataHelper!.loadArticles().isEmpty)
        XCTAssertEqual(coreDataTest.coreDataHelper!.loadArticles()[0].id, random)
    }
    
    
    func testAttemptUpdate(){
        
        let coreDataTest = CoreDataTest()
        // Check to see if the db is empty
        XCTAssert(coreDataTest.coreDataHelper!.loadArticles().isEmpty)
        
        // Create dummy object
        let random = Int.random(in: 1..<500)

        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: coreDataTest.managedObjectContext!)
        let articleObj = NSManagedObject(entity: entity!, insertInto: coreDataTest.managedObjectContext!)

        articleObj.setValue(random, forKey: "id")
        articleObj.setValue("New title! \(random)", forKey: "title")
        articleObj.setValue("summary", forKey: "summary")
        articleObj.setValue("datehere", forKey: "publishedAt")
        articleObj.setValue("https://www.google.com", forKey: "imageUrl")
        articleObj.setValue("https://www.google.com", forKey: "newsSite")
        articleObj.setValue(50.0, forKey: "progress")
        articleObj.setValue("https://www.google.com", forKey: "url")
        
        let article = Article(articleObj)
        
        // Save Dummy object
        
        coreDataTest.coreDataHelper!.attemptUpdate(article)
        
        // See if it exists
        
        XCTAssertFalse(coreDataTest.coreDataHelper!.loadArticles().isEmpty)
        XCTAssertEqual(coreDataTest.coreDataHelper!.loadArticles()[0].id, random)
        XCTAssertEqual(coreDataTest.coreDataHelper!.loadArticles()[0].title, article.title)

        // Wipe out
        
        // Carried on from above test.
        // Update the article
        articleObj.setValue("Rocket News!", forKey: "title")
        let newArticle = Article(articleObj)
        coreDataTest.coreDataHelper!.attemptUpdate(newArticle)
        XCTAssertFalse(coreDataTest.coreDataHelper!.loadArticles().isEmpty)
        XCTAssertEqual(coreDataTest.coreDataHelper!.loadArticles()[0].id, random)
        XCTAssertEqual(coreDataTest.coreDataHelper!.loadArticles()[0].title, newArticle.title)
        
    }
    
   
    //MARK:: Article ViewModel Tests
    
    func testCheckProgress(){
        
        let coreDataTest = CoreDataTest()
        let random = Int.random(in: 1..<500)

        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: coreDataTest.managedObjectContext!)
        let articleObj = NSManagedObject(entity: entity!, insertInto: coreDataTest.managedObjectContext!)

        articleObj.setValue(random, forKey: "id")
        articleObj.setValue("New title! \(random)", forKey: "title")
        articleObj.setValue("summary", forKey: "summary")
        articleObj.setValue("datehere", forKey: "publishedAt")
        articleObj.setValue("https://www.google.com", forKey: "imageUrl")
        articleObj.setValue("https://www.google.com", forKey: "newsSite")
        articleObj.setValue(50.0, forKey: "progress")
        articleObj.setValue("https://www.google.com", forKey: "url")
        
        let article = Article(articleObj)
        
        let articleVM = ArticleViewModel(article)
        
        // Make sure its currently empty.
        XCTAssertEqual(articleVM.progress, 0.0)
        
        // Signal that a scroll has occured
        articleVM.checkProgress(100.0, 50.0)
        
        // Updated progress should be 50%
        XCTAssertEqual(articleVM.progress, 50.0)
        
        // Signal that a scroll has occured for the full ESTIMATE of the page
        articleVM.checkProgress(100.0, 65.0)
        
        // Signal again that a scroll has occured for the full page
        articleVM.checkProgress(100.0, 100.0)
        
        // Check to see the current scroll progress. It should be 65 since that is the cap, and the last signal should not have progressed.
        XCTAssertEqual(articleVM.progress, 65.0)
    }
    
}
