//
//  RssFullProtocols.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation

import UIKit
import IGListKit

protocol RssFullViewProtocol: class {
    func show(data: [ListDiffable], animated: Bool)
}

protocol RssFullPresenterProtocol: class {
    
    var interactor: RssFullInteractorInputProtocol? { get set }
    var view: RssFullViewProtocol? { get set }
    var router: RssFullRouterProtocol? { get set }
    
    var rssItem: RssItem? { get set }
    
    func viewDidLoad()

    
}

protocol RssFullInteractorInputProtocol: class {
    
    var presenter: RssFullInteractorOutputProtocol? { get set }
    
}

protocol RssFullInteractorOutputProtocol: class {
    
}

protocol RssFullRouterProtocol: class {
    
    static func createRssFullModule(for item: RssItem) -> RssFullViewController
    
}
