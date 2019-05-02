//
//  YZTestViewController.swift
//  YZTableViewExample
//
//  Created by Yaroslav Zavyalov on 27/04/2019.
//  Copyright © 2019 Yaroslav Zavyalov. All rights reserved.
//

import UIKit
import YZTableView

class YZTestViewController: UIViewController {
    
    private var tableView: YZTableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
}

// MARK: - Privates
extension YZTestViewController {
    
    private func createUI() {
        self.view.backgroundColor = .white
        self.title = "Test"
        
        self.tableView = YZTableView(cells: [UITableViewCell.self])
        self.tableView?.delegate = self
    }
}

// MARK: - YZTableViewProtocol
extension YZTestViewController: YZTableViewProtocol {
    
    func getLoaderView() -> UIView? {
        return nil
    }
    
    func getRefreshControl() -> UIRefreshControl? {
        return nil
    }
    
    func getNoContentView() -> UIView? {
        return nil
    }
    
    func isContentHeightEqualTableViewHeight() -> Bool {
        return false
    }
}

