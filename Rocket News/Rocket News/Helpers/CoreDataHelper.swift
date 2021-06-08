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
    
    
    
    
    
    // Initializer for general usage in History tab
    init(_ appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    // Initializer for saving articles
    init(_ appDelegate: AppDelegate, _ article: Article, _ progress: Float) {
        self.appDelegate = appDelegate
        self.progress = progress
        context = appDelegate.persistentContainer.viewContext
        attemptUpdate(article)
    }

    func saveArticle(_ article: Article){
        
        print("\(article.id) - \(article.title) -- saving new at \(progress)")
        
        context = appDelegate!.persistentContainer.viewContext
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

        
        print("Saving Data..")
        do {
            try context.save()
        } catch {
            print("saving data Failed")
        }
    }
    
    func attemptUpdate(_ article: Article){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "id = %ld", article.id)
        
        
        var results: [Any] = []
        
        do {
            results = try context.fetch(request)
            for data in results as! [NSManagedObject] {
                print("The article already exists! Saving at \(progress)")
                // Since the data exists, update the progress here.
                data.setValue(progress, forKey: "progress")
            }
        } catch {
            print("Error out \(error.localizedDescription)")
        }
        
        if (results.count == 0 ) {
            saveArticle(article)
        }
    }
    
    
    func deleteAll(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
                try context.save()
                print("Deleting article")
            }
        } catch {
            print("Error loading data")
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
            print("Error loading data")
        }
        
        articles.sorted(by: {$0.title > $1.title})
        return articles
    }
    
    
}
