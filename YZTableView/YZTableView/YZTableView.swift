//
//  YZTableView.swift
//  YZTableView
//
//  Created by Yaroslav Zavyalov on 27/04/2019.
//  Copyright © 2019 Yaroslav Zavyalov. All rights reserved.
//

import UIKit

public protocol YZTableViewProtocol: class {
    func getLoaderView() -> UIView?
    func getRefreshControl() -> UIRefreshControl?
    func getNoContentView() -> UIView?
    func isContentHeightEqualTableViewHeight() -> Bool
}

open class YZTableView: UITableView {
    
    public weak var viewDelegate: YZTableViewProtocol?
    private var isLoading: Bool = false
}

// MARK: - Public methods
extension YZTableView {
    
    public func reusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    public func startLoading() {
        if self.isLoading { return }
        self.isLoading = true
        
        if let loaderView = self.viewDelegate?.getLoaderView() {
            loaderView.layoutIfNeeded()
            self.tableFooterView = loaderView
        }
    }
    
    public func stopLoading() {
        if !self.isLoading { return }
        self.isLoading = false
        
        self.createRefreshControl()
    }
    
    public func setCells(_ cells: [AnyClass]) {
        cells.forEach {
            if let casted = $0.self as? UITableViewCell.Type {
                let reuseIdentifier = String(describing: casted.self)
                self.register($0, forCellReuseIdentifier: reuseIdentifier)
            }
        }
    }
}

// MARK: - Privates
extension YZTableView {
    
    private func createRefreshControl() {
        self.refreshControl = self.viewDelegate?.getRefreshControl()
    }
    
    private func removeRefreshControl() {
        self.refreshControl?.removeFromSuperview()
        self.refreshControl = nil
    }
}
