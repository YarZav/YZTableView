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
    private var models = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNewModels()
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
        self.tableView.tableFooterView = UIView()
        
        self.view.addSubview(self.tableView)
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .left, .right, .bottom]
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        attributes.forEach {
            NSLayoutConstraint(item: self.tableView, attribute: $0, relatedBy: .equal, toItem: self.view, attribute: $0, multiplier: 1, constant: 0).isActive = true
        }
    }
    
    private func setNewModels() {
        self.tableView.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            var newIndexPaths = [IndexPath]()
            var newModels = [Int]()
            for i in 0..<20 {
                newModels.append(Int.random(in: 0..<100))
                newIndexPaths.append(IndexPath(row: (self.models.count + i), section: 0))
            }
            self.models.append(contentsOf: newModels)
            
            self.tableView.beginUpdates()
            if self.models.isEmpty {
                self.tableView.insertSections(IndexSet(integer: 0), with: .automatic)
            }
            self.tableView.insertRows(at: newIndexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDelegate
extension YZTestViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension YZTestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.reusableCell(indexPath: indexPath)
        cell.textLabel?.text = "\(self.models[indexPath.row])"
        return cell
    }
}

// MARK: - YZTableViewProtocol
extension YZTestViewController: YZTableViewProtocol {

    func getLoaderView() -> UIView? {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.startAnimating()

        return loader
    }

    func getRefreshControl() -> UIRefreshControl? {
        let refresh = UIRefreshControl()
        return refresh
    }

    func getNoContentView() -> UIView? {
        return nil
    }

    func isContentHeightEqualTableViewHeight() -> Bool {
        return false
    }
}

