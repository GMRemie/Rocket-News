//
//  Article.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import CoreData

struct Article: Codable {
    
    // Side note: Article could extend NSManagedObject as well - but due to unfamiliarity with doing such, I left this as a codable.
    
    
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var publishedAt: String
    var summary: String
    var progress:Float = 0
    
    private enum CodingKeys: String, CodingKey {
        case id,title,url,imageUrl,newsSite,publishedAt,summary
    }
    

    init(_ data: NSManagedObject) {
        self.id = data.value(forKey: "id") as! Int
        self.title = data.value(forKey: "title") as! String
        self.url = data.value(forKey: "url") as! String
        self.imageUrl = data.value(forKey: "imageUrl") as! String
        self.newsSite = data.value(forKey: "newsSite") as! String
        self.publishedAt = data.value(forKey: "publishedAt") as? String ?? ""
        self.summary = data.value(forKey: "summary") as? String ?? ""
        self.progress = data.value(forKey: "progress") as! Float
    }
    
}
