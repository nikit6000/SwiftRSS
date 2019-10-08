//
//  RssPreviewRouter.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit

class RssPreviewRouter: RssPreviewRouterProtocol {
    
    static func createRssPreviewModule(ref: RssPreviewViewController) {
        let presenter = RssPreviewPresenter()
        let interactor = RssPreviewInteractor()
        let router = RssPreviewRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = ref
        
        interactor.presenter = presenter
        
        ref.presenter = presenter
        
    }
    
    func presentFullView(from view: RssPreviewViewProtocol, for item: RssItem) {
        let controller = RssFullRouter.createRssFullModule(for: item)
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
