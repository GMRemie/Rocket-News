//
//  ArticleViewController.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/7/21.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    var article: Article?
    var dataModel: ArticleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModel = ArticleViewModel(article!)
        
        guard let article = article else {
            return
        }
        self.title = article.title
        
        setupWeb()

        // Hook into the view models functions
        
        dataModel!.closeView = {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    
    
    @IBAction func closeArticleClicked(_ sender: UIBarButtonItem) {
        dataModel!.prepareToClose()
    }
    
    
    
}

extension ArticleViewController: WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    func setupWeb(){
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        let articleUrl = URL(string: article!.url)
        
        webView.load(URLRequest(url: articleUrl!))
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Make sure the webpage isn't loading. Because it can result in percentages like -10 or +10 prior to even scrolling.
        if (!webView.isLoading){
            dataModel!.checkProgress(scrollView.contentSize.height, scrollView.contentOffset.y)
        }
    }
    
    
}
