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
        
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 260

        
        dataModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        dataModel.request()
        
    }
    
    
    // Pass the selected article into the article view controller. Since it's in a navigation controller, we need to first target the navigation controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let NavigationController = segue.destination as? UINavigationController {
            if let DestinationViewController = NavigationController.topViewController as? ArticleViewController{
                DestinationViewController.article = dataModel.cellAtIndex(tableView.indexPathForSelectedRow!.row)
            }
        }
    }



}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
        cell.tag = dataModel.cellAtIndex(indexPath.row).id
        cell.populateCell(dataModel.cellAtIndex(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // News article has been selected
        self.performSegue(withIdentifier: "viewArticle", sender: self)
    }
    
}
