//
//  ItemCollectionViewCell.swift
//  test
//
//  Created by Jaime Capponi on 20-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import UIKit
import FontAwesome_swift


class ItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties.
    
    private var item: Item? {
        didSet {
            if let item = item {
                nameLabel.text = item.title
                iconImageView.image = UIImage.fontAwesomeIcon(
                    code: "fa-\(item.icon)",
                    style: .regular,
                    textColor: UIColor.Color.icon,
                    size: iconImageView.frame.size
                )
            }
        }
    }
    
    // MARK: - @IBOutlets.
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = UIColor.Color.itemText
            nameLabel.textAlignment = .center
            nameLabel.numberOfLines = 2
            nameLabel.font = .boldSystemFont(ofSize: 11)
            
        }
    }
    
    // MARK: - UINibLoading
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.Color.item
        self.layer.cornerRadius = 10
    }
}

// MARK: - Public functions.

extension ItemCollectionViewCell {
    func setUp(item: Item) {
        self.item = item
    }
}
