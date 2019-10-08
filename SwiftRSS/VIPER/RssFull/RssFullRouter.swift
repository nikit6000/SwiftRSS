//
//  RssFullRouter.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation

class RssFullRouter: RssFullRouterProtocol {
    
    static func createRssFullModule(for item: RssItem) -> RssFullViewController {
        
        let view = RssFullViewController()
        
        let presenter = RssFullPresenter()
        let interactor = RssFullInteractor()
        let router = RssFullRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.rssItem = item
        
        interactor.presenter = presenter
        
        view.presenter = presenter
        
        return view
    }
    
    
}
