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
            articles = articles.sorted(by: {$0.id > $1.id})
            refreshTableViews?()
        }
    }
    
    
    init(_ appDelegate: AppDelegate) {
        coreDataHelper = CoreDataHelper(appDelegate)
        articles = coreDataHelper!.loadArticles()
    }
    
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
