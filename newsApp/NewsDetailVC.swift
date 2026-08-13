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
    
    

    @IBOutlet weak var sourceLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel? // Dummy connection to prevent SIGABRT
    @IBOutlet weak var contentLabel: UILabel?
    @IBOutlet weak var newsImageView: UIImageView?
    
        override func viewDidLoad() {
            super.viewDidLoad()

            applyVibrantGradientBackground()
            setupUI()
        }

        func setupUI() {

            guard let news = newsItem else { return }
            
            // Set up save icon based on state
            updateSaveIcon()
            
            // Set text colors for glassmorphic contrast
            // Set text colors for light background
            titleLabel?.textColor = .black
            sourceLabel?.textColor = .darkGray
            dateLabel?.textColor = .darkGray
            authorLabel?.textColor = .darkGray
            contentLabel?.textColor = .black
            
            // Professional Typography and Spacing (Adjusted to be smaller)
            titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            titleLabel?.numberOfLines = 2
            titleLabel?.text = news.title
            
            sourceLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            sourceLabel?.textColor = UIColor.systemBlue // Professional Accent
            sourceLabel?.text = news.source.name
            
            dateLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            dateLabel?.text = news.publishedAt
            
            authorLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            authorLabel?.text = news.author ?? "Unknown Author"
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            
            contentLabel?.numberOfLines = 0 // Allow it to expand naturally or truncate based on storyboard constraints
            
            let contentText = news.content ?? ""
            
            let fullText = NSMutableAttributedString(string: contentText + (contentText.isEmpty ? "" : " "), attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.black
            ])
            
            let linkText = NSAttributedString(string: "Read Full Article", attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
            
            fullText.append(linkText)
            contentLabel?.attributedText = fullText
            
            contentLabel?.isUserInteractionEnabled = true
            if let contentLbl = contentLabel {
                let tap = UITapGestureRecognizer(target: self, action: #selector(openFullArticle))
                contentLbl.addGestureRecognizer(tap)
            }

            if let imageURL = news.urlToImage {
                newsImageView?.sd_setImage(with: URL(string: imageURL))
            }
            
            newsImageView?.layer.cornerRadius = 20
            newsImageView?.clipsToBounds = true
            newsImageView?.layer.borderWidth = 0.5
            newsImageView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        }

        
    func updateSaveIcon() {
        let isSaved = SavedNewsManager.shared.isSaved(newsItem)
        let iconName = isSaved ? "bookmark.fill" : "bookmark"
        let saveIcon = UIImage(systemName: iconName)
        let saveButton = UIBarButtonItem(image: saveIcon, style: .plain, target: self, action: #selector(saveArticleIconTapped))
        self.navigationItem.rightBarButtonItem = saveButton
    }

    @objc func saveArticleIconTapped() {
        SavedNewsManager.shared.toggleSave(newsItem)
        updateSaveIcon() // Refresh icon state visually
        
        let isSaved = SavedNewsManager.shared.isSaved(newsItem)
        let message = isSaved ? "News saved successfully." : "News removed from saved items."
        let alert = UIAlertController(title: isSaved ? "Saved" : "Unsaved", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func openFullArticle() {
        guard let url = newsItem?.url else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsWebKitVc") as! NewsWebKitVc
        vc.articleURL = url
        navigationController?.pushViewController(vc, animated: true)
    }

    // Dummy connections to prevent SIGABRT if orphaned connections exist in Storyboard
    @IBAction func seeMoreButtonTapped(_ sender: Any) {}
    @IBAction func saveButtonTapped(_ sender: Any) {}
}
