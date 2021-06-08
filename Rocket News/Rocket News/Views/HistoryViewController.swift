//
//  HistoryViewController.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var dataModel: HistoryViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 260

        
        
        dataModel = HistoryViewModel(UIApplication.shared.delegate as! AppDelegate)

        // Do any additional setup after loading the view.
        
        dataModel?.refreshTableViews = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataModel?.refreshProgress()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let NavigationController = segue.destination as? UINavigationController {
            if let DestinationViewController = NavigationController.topViewController as? ArticleViewController{
                DestinationViewController.article = dataModel?.getArticleByIndex(tableView.indexPathForSelectedRow!.row)
            }
        }
    }
}


extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel!.getArticleCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = dataModel!.getArticleByIndex(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
        cell.populateCell(article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewArticle", sender: self)
    }
    
}
