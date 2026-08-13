//
//  TableViewCell.swift
//  newsApp
//
//  Created by enjay on 20/06/26.
//

import UIKit

class TabelViewCellSv: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var sourceLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(containerView, at: 0)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        containerView.layoutIfNeeded()
        containerView.applyGlassEffect(cornerRadius: 16, borderAlpha: 0.3)
        
        newsImage.layer.cornerRadius = 12
        newsImage.clipsToBounds = true
        
        titleLabel.textColor = .black
        sourceLabel.textColor = .darkGray
        dateLabel.textColor = .darkGray
    }

    

}

