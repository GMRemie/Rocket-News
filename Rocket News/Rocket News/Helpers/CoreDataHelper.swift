//
//  CoreDataHelper.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import CoreData


class CoreDataHelper {
    
    // We're going to need to hold reference to the AppDelegate to access CoreData
    var appDelegate: AppDelegate?
    var context:NSManagedObjectContext!
    var progress: Float = 0.0
    
    
    // Coredata initializer for unit tests, this context saves data into memory rather than disk. Refer to CoreDataTest for more info.
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Initializer for general usage, such as HistoryViewModel.
    init(_ appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    // Initializer for directly saving an article.
    init(_ appDelegate: AppDelegate, _ article: Article, _ progress: Float) {
        self.appDelegate = appDelegate
        self.progress = progress
        context = appDelegate.persistentContainer.viewContext
        // Attempt update is called first, because it will either update an existing entry, or save a new entry.
        attemptUpdate(article)
    }

    func saveArticle(_ article: Article){
        
        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: context)
        let articleObj = NSManagedObject(entity: entity!, insertInto: context)

        articleObj.setValue(article.id, forKey: "id")
        articleObj.setValue(article.title, forKey: "title")
        articleObj.setValue(article.summary, forKey: "summary")
        articleObj.setValue(article.publishedAt, forKey: "publishedAt")
        articleObj.setValue(article.imageUrl, forKey: "imageUrl")
        articleObj.setValue(article.newsSite, forKey: "newsSite")
        articleObj.setValue(progress, forKey: "progress")
        articleObj.setValue(article.url, forKey: "url")

        do {
            try context.save()
        } catch {
            print("saving data Failed")
        }
    }
    
    func attemptUpdate(_ article: Article){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        request.returnsObjectsAsFaults = false
        // Use a predicate to check to see if an entry exists with the current uuid.
        request.predicate = NSPredicate(format: "id = %ld", article.id)
        
        var results: [Any] = []
        
        do {
            results = try context.fetch(request)
            for data in results as! [NSManagedObject] {
                // Since the data exists, update the progress here.
                data.setValue(progress, forKey: "progress")
            }
        } catch {
            print("Error out \(error.localizedDescription)")
        }
        
        if (results.count == 0 ) {
            // Since the entry doesn't exist, save a new one.
            saveArticle(article)
        }
    }

    func loadArticles() -> [Article]{
        var articles:[Article] = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                articles.append(Article(data))
            }
        } catch {
            print("Error loading data \(error.localizedDescription)")
        }
        
        articles.sorted(by: {$0.title > $1.title})
        return articles
    }
    
    
}
