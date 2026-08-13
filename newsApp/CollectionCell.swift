//
//  CollectionCell.swift
//  newsApp
//
//  Created by enjay on 20/06/26.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var collectionCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // Add a container for glass effect
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(containerView, at: 0)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4)
        ])
        
        containerView.layoutIfNeeded()
        containerView.applyGlassEffect(cornerRadius: 12, borderAlpha: 0.4)
        
        collectionCellLabel.textColor = .black
        collectionCellLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
}
