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

open class YZTableView: UIView {
    
    public var tableView = UITableView()
    public weak var delegate: YZTableViewProtocol?
    
    private var isLoading: Bool = false
    private var refreshControl: UIRefreshControl?
    
    public weak var tableDelegate: UITableViewDelegate? {
        didSet {
            self.tableView.delegate = self.tableDelegate
        }
    }
    
    public weak var tableDataSource: UITableViewDataSource? {
        didSet {
            self.tableView.dataSource = self.tableDataSource
        }
    }
    
    public var cells: [AnyClass]? {
        didSet {
            self.cells?.forEach {
                if let casted = $0.self as? UITableViewCell.Type {
                    let reuseIdentifier = String(describing: casted.self)
                    self.tableView.register($0, forCellReuseIdentifier: reuseIdentifier)
                }
            }
        }
    }

    public init(cells: [AnyClass]) {
        self.cells = cells
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createUI()
    }
}

// MARK: - Public methods
extension YZTableView {
    
    public func startLoading() {
        if self.isLoading { return }
        self.isLoading = true
    }
    
    public func stopLoading() {
        if !self.isLoading { return }
        self.isLoading = false
        
        self.createRefreshControl()
    }
}

// MARK: - Privates
extension YZTableView {
    
    private func createUI() {
        self.addSubview(self.tableView)
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .left, .right, .bottom]
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        attributes.forEach {
            NSLayoutConstraint(item: self.tableView, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0).isActive = true
        }
    }
    
    private func createRefreshControl() {
        self.tableView.refreshControl = self.delegate?.getRefreshControl()
    }
    
    private func removeRefreshControl() {
        self.refreshControl?.removeFromSuperview()
        self.refreshControl = nil
    }
}
