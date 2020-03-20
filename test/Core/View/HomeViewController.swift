//
//  HomeViewController.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import UIKit

protocol HomeViewControllerLogic: class {
    func loadItems()
    func showError()
    
}

class HomeViewController: UIViewController {
    
    // MARK: - Private properties.
    
    private let presenter: HomePresenterLogic
    
    // MARK: - @IBOutlets.
    
//    @IBOutlet weak var listTableView: UITableView! {
//        didSet {
//            listTableView.dataSource = self
//            listTableView.delegate = self
//            listTableView.rowHeight = UITableView.automaticDimension
//            listTableView.separatorStyle = .none
//            listTableView.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
//            let itemCell = UINib(nibName: ItemTableViewCell.className, bundle: Bundle(for: ItemTableViewCell.classForCoder()))
//            listTableView.register(itemCell, forCellReuseIdentifier: ItemTableViewCell.className)
//            let emptyCell = UINib(nibName: EmptyTableViewCell.className, bundle: Bundle(for: EmptyTableViewCell.classForCoder()))
//            listTableView.register(emptyCell, forCellReuseIdentifier: EmptyTableViewCell.className)
//        }
//    }
    
    // MARK: - Initializers.
    
    init(_ presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: HomeViewController.className, bundle: Bundle(for: HomeViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getItems()
    }
}

// MARK: - Private functions.

private extension HomeViewController {
    
    
}

// MARK: - ListViewControllerLogic.

extension HomeViewController: HomeViewControllerLogic {

    func loadItems() {
        //listTableView.reloadData()
    }
    
    func showError() {
        
    }
}

// MARK: - UITableView

//extension ListViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.items.count == 0 ? 1 : presenter.items.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard presenter.items.count > 0 else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.className) as? EmptyTableViewCell
//            return cell ?? UITableViewCell()
//        }
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.className) as? ItemTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.setUp(indexPath: indexPath, item: presenter.items[indexPath.row])
//        return cell
//    }
//}
