//
//  RssPreviewProtocols.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit
import IGListKit

protocol RssPreviewViewProtocol: class {
    func show(data: [ListDiffable], animated: Bool)
    func stopLoading()
    func show(error: Error?)
    func setup(categories: [String])
}

protocol RssPreviewPresenterProtocol: class {
    
    var interactor: RssPreviewInteractorInputProtocol? { get set }
    var view: RssPreviewViewProtocol? { get set }
    var router: RssPreviewRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func filter(category: String?)
    
}

protocol RssPreviewInteractorInputProtocol: class {
    
    var presenter: RssPreviewInteractorOutputProtocol? { get set }
    
    func getRss(from stringUrl: String)
    func applyFilter(category: String?)
    
}

protocol RssPreviewInteractorOutputProtocol: class {
    
    func ready(rss: RssChannel?)
    func ready(rssItems: [RssItem])
    func onError(_ error: Error?)
    
}

protocol RssPreviewRouterProtocol: class {
    
    static func createRssPreviewModule(ref: RssPreviewViewController)
    
    func presentFullView(from view: RssPreviewViewProtocol, for item: RssItem)
}

