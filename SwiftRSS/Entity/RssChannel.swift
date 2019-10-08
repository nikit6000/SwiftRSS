//
//  RssChannel.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation
import IGListKit
import SwiftyXML

class RssChannel: Entity {
    
    private(set) var title: String
    private(set) var about: String?
    private(set) var desc: String?
    private(set) var link: String?
    
    private(set) var items: [RssItem]
    
    private(set) var categiries: [String] = []
    
    required init?(xml: XML) {
        
        guard let title = xml.title.string else {
            return nil
        }
        
        let descKey = XMLSubscriptKey.key("description")
        
        self.title = title
        
        self.about = xml.about.string
        self.desc = xml[descKey].string
        self.link = xml.link.string
        
        self.items = []
        
        for item in xml.item {
            if let rssItem = RssItem(xml: item) {
                
                if !categiries.contains(rssItem.category) {
                    categiries.append(rssItem.category)
                }
                items.append(rssItem)
            }
        }
        
        super.init()
        
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? RssChannel else {
            return false
        }
        
        return  (self.title == object.title) &&
                (self.about == object.about) &&
                (self.desc == object.desc) &&
                (self.link == object.link)
    }
    
}
