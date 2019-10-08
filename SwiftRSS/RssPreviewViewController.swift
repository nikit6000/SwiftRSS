//
//  RssPreviewViewController.swift
//  SwiftRSS
//
//  Created by Nikita Tarkhov on 07/10/2019.
//  Copyright © 2019 Nikita Tarkhov. All rights reserved.
//

import UIKit
import IGListKit

class RssPreviewViewController: UIViewController, RssPreviewViewProtocol {

    //MARK: - Public vars
    var presenter: RssPreviewPresenterProtocol?
    
    //MARK: - Private vars
    
    private var data: [ListDiffable] = []
    private var filterAlert:UIAlertController?
    
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
    
    private lazy var filterButton: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let image = #imageLiteral(resourceName: "filter-tool-black-shape (1)")
        
        view.backgroundColor = .clear
        view.setImage(image, for: .normal)
        
        view.addTarget(self, action: #selector(RssPreviewViewController.showFilterAlert), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
    
        control.addTarget(self, action: #selector(RssPreviewViewController.getData), for: .valueChanged)
        
        return control
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
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.view.addSubview(collectionView)
        
        self.collectionView.addSubview(refreshControl)
        
        setupConstaraints()
        
        RssPreviewRouter.createRssPreviewModule(ref: self)
        presenter?.viewDidLoad()
    }
    
    //MARK: - Public func
    
    public func show(data: [ListDiffable], animated: Bool) {
        self.data = data
        
        adapter.performUpdates(animated: animated, completion: nil)
    }
    
    public func show(error: Error?) {
        
        let description: String = (error == nil) ? "Unknown error" : error!.localizedDescription
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    public func stopLoading() {
        refreshControl.endRefreshing()
    }
    
    public func setup(categories: [String]) {
        let alert = UIAlertController(title: "Select category", message: nil, preferredStyle: .actionSheet)
        
        for category in categories {
            let alertAction = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.presenter?.filter(category: category)
            }
            alert.addAction(alertAction)
        }
        
        let allAction = UIAlertAction(title: "All", style: .default) { [weak self] _ in
            self?.presenter?.filter(category: nil)
        }
        
        alert.addAction(allAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        filterAlert = alert
    }
    
    //MARK: - Private func
    
    private func setupConstaraints() {
        
        /* collectionView */
        
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view!, attribute: .trailing, relatedBy: .equal, toItem: collectionView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
    
    @objc private func showFilterAlert() {
        
        if let alert = filterAlert {
            self.present(alert, animated: true)
            return
        }
        
        let error = NSError(domain: "No filter data", code: 228)
        
        
        show(error: error)
        
    }
    
    @objc private func getData() {
        presenter?.interactor?.getRss(from: "https://www.vesti.ru/vesti.rss")
    }


}

//MARK: - ListAdapterDataSource protocol

extension RssPreviewViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is RssItem:
            return RssPreviewController()
        default:
            fatalError("Section controller for object is not implemented!")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
