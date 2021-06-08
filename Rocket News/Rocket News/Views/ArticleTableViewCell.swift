//
//  ArticleTableViewCell.swift
//  Rocket News
//
//  Created by Joseph Storer on 6/8/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
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
        // do thumbnail image
        title.text = article.title
        source.text = article.newsSite
        progress.text = "0%"
    }
    
}
