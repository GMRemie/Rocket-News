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
            // Once the data is set from the combine publisher, filter the articles to only include https links.
            // This prevents any ATS security issues or errors.
            articles = articles.filter({$0.url.contains("https:")})
            reloadTableView?()
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
    
    let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles")
    private var cancellable: AnyCancellable?
    /*
     Combine network requiest -
        -Create a DataTaskPublisher
        -Extract data
        -Decode the data into the Article Codable
        -Assign data to articles array
     */
    internal func request(){
        self.cancellable = URLSession.shared.dataTaskPublisher(for: self.url!)
            .map({$0.data})
            .decode(type: [Article].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .assign(to: \.articles, on: self)
    }
}
