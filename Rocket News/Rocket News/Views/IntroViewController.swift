//
//  IntroViewController.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var startReadingBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        startReadingBtn.roundCorners()
    }
    

}
