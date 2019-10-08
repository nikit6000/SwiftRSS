//
//  RssFullViewController.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 08/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit
import IGListKit

class RssFullViewController: UIViewController, RssFullViewProtocol {

    //MARK: - Public vars
    var presenter: RssFullPresenterProtocol?
    //MARK: - Private vars
    
    private var data: [ListDiffable] = []
    
    //MARK: Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 40, height: 40)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alwaysBounceHorizontal = false
        
        return view
    }()
    
    //MARK: ListAdapter
    
    private lazy var adapter: ListAdapter = {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        
        adapter.dataSource = self
        adapter.collectionView = self.collectionView
        
        return adapter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RSS"
        
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.view.addSubview(collectionView)
        
        setupConstaraints()
    
        presenter?.viewDidLoad()
    }
    
    //MARK: - Public func
    
    func show(data: [ListDiffable], animated: Bool) {
        self.data = data
        adapter.performUpdates(animated: animated, completion: nil)
    }
    
    //MARK: - Private func
    
    private func setupConstaraints() {
        
        /* collectionView */
        
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view!, attribute: .trailing, relatedBy: .equal, toItem: collectionView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
    
    deinit {
        print("RssFullViewController - deinited")
    }


}

//MARK: - ListAdapterDataSource protocol

extension RssFullViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is RssItem:
            return RssFullController()
        default:
            fatalError("Section controller for object is not implemented!")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
