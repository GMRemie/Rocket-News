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
    var dataModel = ArticleViewModel()
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let article = article else {
            return
        }
        self.title = article.title
        
        setupWeb()

    }
    
    
    
    @IBAction func closeArticleClicked(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
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
            dataModel.checkProgress(scrollView.contentSize.height, scrollView.contentOffset.y)
        }
    }
    
    
}
