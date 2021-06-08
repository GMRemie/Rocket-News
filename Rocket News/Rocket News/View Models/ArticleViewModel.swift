//
//  ArticleViewModel.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import UIKit


class ArticleViewModel {

    var progress:CGFloat = 0.0
    var estimateCompleted:CGFloat = 65.0

    
    
    func checkProgress(_ contentHeight: CGFloat, _ contentOffSet: CGFloat){
        
        if (progress < estimateCompleted){
            
            let currentProgress = (contentOffSet / contentHeight) * 100
                
            print("Progress \(currentProgress)%")
            progress = currentProgress

        }
    }
}
