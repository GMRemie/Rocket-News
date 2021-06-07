//
//  Article.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation


struct Article: Codable {
    
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var publishedAt: String
    var summary: String
}
