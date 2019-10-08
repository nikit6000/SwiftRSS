//
//  RssPreviewInteractor.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation

class RssPreviewInteractor: RssPreviewInteractorInputProtocol {
    
    private var rssChannel: RssChannel?
    
    var presenter: RssPreviewInteractorOutputProtocol?
    
    
    func getRss(from stringUrl: String) {
        let util = RssUtil.shared
        
        if let url = URL(string: stringUrl) {
            util.get(rss: url, complete: { [weak self] channel in
                self?.rssChannel = channel
                self?.presenter?.ready(rss: channel)
            }, fail: { [weak self] error in
                self?.presenter?.onError(error)
            })
        } else {
            self.presenter?.ready(rss: nil)
        }
        
        
    }
    
    func applyFilter(category: String?) {
        
        if (category == nil || rssChannel == nil) {
            presenter?.ready(rss: rssChannel)
            return
        }
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            let filtred = strongSelf.rssChannel!.items.filter {
                return $0.category == category
            }
            
            DispatchQueue.main.async {
                strongSelf.presenter?.ready(rssItems: filtred)
            }
            
        }
        
        
    }
    
}
