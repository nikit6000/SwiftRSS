//
//  RssFullPresenter.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation

class RssFullPresenter : RssFullPresenterProtocol {
    
    var interactor: RssFullInteractorInputProtocol?
    
    var view: RssFullViewProtocol?
    
    var router: RssFullRouterProtocol?
    
    var rssItem: RssItem? {
        didSet {
            if rssItem != nil {
                view?.show(data: [rssItem!], animated: true)
            }
        }
    }
    
    func viewDidLoad() {
        if rssItem != nil {
            view?.show(data: [rssItem!], animated: true)
        }
    }
    
    
}

extension RssFullPresenter : RssFullInteractorOutputProtocol {
    
}
