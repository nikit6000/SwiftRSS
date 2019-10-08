//
//  RssUtil.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXML

typealias RssComleteBlock = (_ channel: RssChannel) -> ()
typealias RssErrorBlock = (_ error: Error) -> ()

enum RssUtilError: Error {
    case badResponse
    case cantParseXML
    case cantParseModel
}

class RssUtil {
    
    static var shared = RssUtil()
    
    public func get(rss link: URL, complete: RssComleteBlock? = nil, fail: RssErrorBlock? = nil) {
        
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        Alamofire.request(link, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString(queue: utilityQueue) { data in
            
            if data.error != nil {
                DispatchQueue.main.async {
                    fail?(data.error!)
                }
                return
            }
            
            guard let responseStr = data.result.value else {
                DispatchQueue.main.async {
                    fail?(RssUtilError.badResponse)
                }
                return
            }
            
            guard let xml = XML(string: responseStr).channel.xml else {
                DispatchQueue.main.async {
                    fail?(RssUtilError.cantParseXML)
                }
                return
            }
            
            guard let channel = RssChannel(xml: xml) else {
                DispatchQueue.main.async {
                    fail?(RssUtilError.cantParseModel)
                }
                return
            }
            
            DispatchQueue.main.async {
                complete?(channel)
            }
            
        }
    }
    
}

