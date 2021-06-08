//
//  ArticleViewModel.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import UIKit


class ArticleViewModel {

    
     /*The estimated completion float is based on the size of the web page without extraneous sections IE comment boxes.
     Typically from this API around 65% of the page is accurate. If given more time, you could probably take the actual article height - comment section for a more
     accurate representation.
     */
    var estimateCompleted:CGFloat = 65.0
    var progress:CGFloat = 0.0

    var article: Article?
    
    var closeView: (() -> ())?
    
    init(_ article: Article) {
        self.article = article
    }
    
    
    func prepareToClose(){
        
        // testing
       let _ = CoreDataHelper((UIApplication.shared.delegate as! AppDelegate ), article!, Float(progress))

        closeView?()
        
    }

    
    
    func checkProgress(_ contentHeight: CGFloat, _ contentOffSet: CGFloat){
        
        if (progress < estimateCompleted){
            
            let currentProgress = (contentOffSet / contentHeight) * 100
                
            print("Progress \(currentProgress)%")
            progress = currentProgress

        }
    }
}
