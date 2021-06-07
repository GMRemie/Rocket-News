//
//  NewsViewModel.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import Combine

class NewsViewModel {
    
    var reloadTableView: (() -> ())?
    
    var articles: [Article] = []{
        didSet{
            print("Updated")
            print(articles[0].url)
        }
    }
    
    
    
    var numberOfCells: Int {
        get {
            return articles.count
        }
    }
    
    public func cellAtIndex( _ indexPath: Int ) -> Article {
        return articles[indexPath]
    }


    
    var url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles")
    private var cancellable: AnyCancellable?

    internal func request(){
        self.cancellable = URLSession.shared.dataTaskPublisher(for: self.url!)
            .map({$0.data})
            .decode(type: [Article].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .assign(to: \.articles, on: self)
        
    }
    
}
