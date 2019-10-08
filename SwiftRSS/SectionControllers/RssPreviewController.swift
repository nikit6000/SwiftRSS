//
//  RssPreviewController.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import IGListKit

class RssPreviewController: ListSectionController {
    
    private let hOffset: CGFloat = 8.0
    private let vOffset: CGFloat = 20.0
    
    private var model: RssItem!
    
    override init() {
        super.init()
        
        self.inset = UIEdgeInsets(top: vOffset, left: hOffset, bottom: vOffset, right: hOffset)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        let width = collectionContext!.containerSize.width - 2 * hOffset
        
        
        
        switch index {
        case 0:
            return CGSize(width: width, height: 0.66 * width + vOffset)
        default:
            return CGSize(width: width, height: 50 + vOffset)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if (index == 0) {
            
            guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell else {
                fatalError()
            }
            
            cell.title = model.title
            cell.imageUrl = model.enclosure
            cell.corners = [.topLeft, .topRight]
            
            return cell
            
        } else {
            
            guard let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index) as? TitleCell else {
                fatalError()
            }
            
            cell.title = model.title
            cell.date = model.pubDate
            cell.corners = [.bottomLeft, .bottomRight]
            return cell
            
        }
        
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func didUpdate(to object: Any) {
        guard let object = object as? RssItem else {
            return
        }
        
        self.model = object
    }
    
    override func didSelectItem(at index: Int) {
        
        guard let viewController = self.viewController as? RssPreviewViewController else {
            return
        }
        
        viewController.presenter?.router?.presentFullView(from: viewController, for: model)
    }
    
}
