//
//  ButtonExtension.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import Foundation
import UIKit


extension UIButton {
    
    func roundCorners(){
        self.layer.cornerRadius = self.frame.size.height * 0.3
    }
}
