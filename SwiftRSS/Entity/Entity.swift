//
//  Entity.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation
import IGListKit
import SwiftyXML

class Entity: NSObject, ListDiffable {
    
    required init?(xml: XML) {
        return nil
    }
    
    override init() {
        super.init()
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.isEqual(object)
    }
    
}
