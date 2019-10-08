//
//  FullCell.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit

class FullCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 3
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 17)
        
        return view
        
    }()
    
    private lazy var dateLabel: UILabel = {
        
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 15)
        
        return view
        
    }()
    
    private lazy var textLabel: UILabel = {
        
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 100
        view.textColor = .black
        view.font = .systemFont(ofSize: 15)
        
        return view
        
    }()
    
    public var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    
    public var date: String? {
        set {
            dateLabel.text = newValue
        }
        get {
            return dateLabel.text
        }
    }
    
    public var text: String? {
        set {
            textLabel.text = newValue
        }
        get {
            return textLabel.text
        }
    }
    
    public var corners: UIRectCorner? = nil
    public var cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(textLabel)
        
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
        
        /* titleLabel */
        
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        //NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        
        /* dateLabel */
        
        NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4).isActive = true
        NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: dateLabel, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        
        /* textLabel */
        
        NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: textLabel, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: textLabel, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = contentView.frame.size.width//ceil(size.width)
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
}
