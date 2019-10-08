//
//  ImageCell.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    
    
    private lazy var imageView: UIImageView = {
        
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        return view
        
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 4
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 17)
        
        return view
        
    }()
    
    public var imageUrl: String? {
        didSet {
            imageView.image = nil
            if let imageUrl = self.imageUrl {
                imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
            }
        }
    }
    
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    public var corners: UIRectCorner? = nil
    public var cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.5333333333, blue: 0.8980392157, alpha: 1)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if corners != nil {
            round(corners: corners!, radius: cornerRadius)
        }
    }
    
    private func setupConstraints() {
        
        /* imageView */
        
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        /* titleLabel */
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        layoutAttributes.frame = imageView.frame
        return layoutAttributes
    }
    
}
