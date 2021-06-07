//
//  NewsViewController.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import UIKit

class NewsViewController: UIViewController {

    var dataModel = NewsViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataModel.request()
        // Do any additional setup after loading the view.
    }
    


}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
