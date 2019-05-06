//
//  YZTestViewController.swift
//  YZTableViewExample
//
//  Created by Yaroslav Zavyalov on 27/04/2019.
//  Copyright © 2019 Yaroslav Zavyalov. All rights reserved.
//

import UIKit
import YZTableView

// MARK: - Test view controller
class YZTestViewController: UIViewController {
    
    private var tableView = YZTableView()

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
        
        self.tableView.setCells([UITableViewCell.self])
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.viewDelegate = self
        
        self.view.addSubview(self.tableView)
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .left, .right, .bottom]
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        attributes.forEach {
            NSLayoutConstraint(item: self.tableView, attribute: $0, relatedBy: .equal, toItem: self.view, attribute: $0, multiplier: 1, constant: 0).isActive = true
        }
    }
}

// MARK: - UITableViewDelegate
extension YZTestViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension YZTestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.reusableCell(indexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
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

