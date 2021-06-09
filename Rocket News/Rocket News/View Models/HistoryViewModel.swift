//
//  HistoryViewModel.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/8/21.
//

import Foundation


class HistoryViewModel {
    
    
    var refreshTableViews: (() -> ())?
    let coreDataHelper: CoreDataHelper?
    
    
    var articles:[Article] = []{
        didSet{
            articles = articles.sorted(by: {$0.progress < $1.progress})
            refreshTableViews?()
        }
    }
    
    
    init(_ appDelegate: AppDelegate) {
        coreDataHelper = CoreDataHelper(appDelegate)
        articles = coreDataHelper!.loadArticles()
    }
    
    // Called when viewdidappear. Refreshes the view, to make sure any progress is updated.
    func refreshProgress(){
        articles.removeAll()
        articles = coreDataHelper!.loadArticles()
    }
    
    func getArticleCount() -> Int {
        return articles.count
    }
    
    func getArticleByIndex(_ index: Int) -> Article {
        return articles[index]
    }
    
    
    
}
