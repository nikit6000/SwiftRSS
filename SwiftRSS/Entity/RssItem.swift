//
//  RssItem.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation
import IGListKit
import SwiftyXML

class RssItem: Entity {
      
    private(set) var title: String
    private(set) var pubDate: String
    private(set) var category: String
    private(set) var fullText: String
    
    private(set) var enclosure: String?
    
    required init?(xml: XML) {
        
        let fullTextKey = XMLSubscriptKey.key("yandex:full-text")
        
        guard   let title = xml.title.string,
                let pubDate = xml.pubDate.string,
                let category = xml.category.string,
                let fullText = xml[fullTextKey].string
        else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: pubDate) {
            dateFormatter.dateFormat = "d MMMM yyyy - HH:mm"
            let strDate = dateFormatter.string(from: date)
            self.pubDate = strDate
        } else {
            self.pubDate = pubDate
        }
  
        self.title = title
        self.fullText = fullText
        self.category = category
        
        self.enclosure = xml.enclosure.$url.string
        
        if self.enclosure == nil {
            
            let key = XMLSubscriptKey.key("media:thumbnail")
            
            self.enclosure = xml[key].$url.string
        }
        
        super.init()
        
    }
    
    override func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? RssItem else {
            return false
        }
        
        return  (self.title == object.title) &&
                (self.pubDate == object.pubDate) &&
                (self.category == object.category) &&
                (self.fullText == object.fullText) &&
                (self.enclosure == object.enclosure)
    }
    
}
