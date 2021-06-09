//
//  ArticleTableViewCell.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/8/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var progress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func populateCell(_ article: Article){
        title.text = article.title
        source.text = article.newsSite
        //Progress string displays the percentage of the progress. Since its 0-65 we want it to appear as 0-100 as it looks better. Then we remove the remainder. 
        let progressString = article.progress > 0 ? "\(String(format: "%.0f", (article.progress / 65) * 100))%" : ""
        progressBar.progress = (article.progress / 65 )
        progress.text = progressString

    }
    
}
