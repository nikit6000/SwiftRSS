//
//  RssPreviewPresenter.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation
import IGListKit

class RssPreviewPresenter: RssPreviewPresenterProtocol {
    
    var interactor: RssPreviewInteractorInputProtocol?
    
    weak var view: RssPreviewViewProtocol?
    
    var router: RssPreviewRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getRss(from: "https://www.vesti.ru/vesti.rss")
    }
    
    func filter(category: String?) {
        interactor?.applyFilter(category: category)
    }
}

extension RssPreviewPresenter: RssPreviewInteractorOutputProtocol {
    
    func ready(rss: RssChannel?) {
        if rss != nil {
            view?.show(data: rss!.items, animated: true)
            view?.setup(categories: rss!.categiries)
            view?.stopLoading()
            return
        }
        
        view?.stopLoading()
        
    }
    
    func ready(rssItems: [RssItem]) {
        
        view?.show(data: rssItems, animated: true)
        view?.stopLoading()
    }
    
    func onError(_ error: Error?) {
        view?.show(error: error)
    }
    
    
}
