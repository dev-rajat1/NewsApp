//
//  NewsDetailVC.swift
//  newsApp
//
//  Created by enjay on 20/06/26.
//

import UIKit
import SDWebImage


class NewsDetailVC: UIViewController {

        var newsItem: News!
    
    

    @IBOutlet weak var sourceLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var authorLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var contentLabel: UILabel!
       @IBOutlet weak var newsImageView: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()

            setupUI()
        }

        func setupUI() {

            guard let news = newsItem else { return }
            
            titleLabel.text = news.title
            sourceLabel.text = news.source.name
            dateLabel.text = news.publishedAt
            authorLabel.text = news.author ?? "Unknown Author"
            descriptionLabel.text = news.description ?? ""

            contentLabel.text = news.content ?? ""

            if let imageURL = news.urlToImage {
            newsImageView.sd_setImage(with: URL(string: imageURL))
                    }
        }
    
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {

            guard let url = newsItem?.url else { return }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let vc = storyboard.instantiateViewController(
                withIdentifier: "NewsWebKitVc"
            ) as! NewsWebKitVc

            vc.articleURL = url

            navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {

        let isSaved = SavedNewsManager.shared.saveNews(newsItem)

            let message: String

            if isSaved {
                message = "News saved successfully."
            } else {
                message = "This news is already saved."
            }

            let alert = UIAlertController(
                title: "Saved News",
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default))

            present(alert, animated: true)
        }
}
