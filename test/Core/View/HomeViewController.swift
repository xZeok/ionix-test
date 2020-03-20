//
//  HomeViewController.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import UIKit

protocol HomeViewControllerLogic: class {
    func showLoading(loading: Bool)
    func loadItems()
    func showError(text: String, _ completion: @escaping Callback)
    func askRUT()
}

class HomeViewController: UIViewController {
    
    // MARK: - Private properties.
    
    private let presenter: HomePresenterLogic
    
    private enum AlertType {
        case standard
        case choice
    }
    
    // MARK: - @IBOutlets.
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.image = #imageLiteral(resourceName: "BackgroundHome")
            backgroundImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .boldSystemFont(ofSize: 16)
            titleLabel.text = String.HomeViewController.title
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 14)
            nameLabel.text = String.HomeViewController.name
        }
    }
    
    @IBOutlet weak var itemsCollectionView: UICollectionView! {
        didSet {
            itemsCollectionView.delegate = self
            itemsCollectionView.dataSource = self
            itemsCollectionView.backgroundColor = .clear
            itemsCollectionView.isScrollEnabled = true
            itemsCollectionView.isPagingEnabled = false
            itemsCollectionView.showsHorizontalScrollIndicator = false
            itemsCollectionView.showsVerticalScrollIndicator = false
            let itemCell = UINib(nibName: ItemCollectionViewCell.className, bundle: Bundle(for: ItemCollectionViewCell.classForCoder()))
            itemsCollectionView.register(itemCell, forCellWithReuseIdentifier: ItemCollectionViewCell.className)
        }
    }
    
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView! {
        didSet {
            loadingActivityIndicatorView.startAnimating()
        }
    }
    
    
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
    
//  private func displayAlert(type: AlertType = .standard, mainAction: String = String.Alert.ok) {
//        let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        alert.addTextField(configurationHandler: { textField in
//            textField.placeholder = "Input your name here..."
//        })
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//
//            if let name = alert.textFields?.first?.text {
//                print("Your name: \(name)")
//            }
//        }))
//
//        self.present(alert, animated: true)
}

// MARK: - ListViewControllerLogic.

extension HomeViewController: HomeViewControllerLogic {
    func showLoading(loading: Bool) {
        loadingActivityIndicatorView.isHidden = !loading
    }
    
    func showError(text: String, _ completion: @escaping Callback) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String.Alert.retry, style: .default, handler: { action in
            completion()
        }))
        self.present(alert, animated: true)
    }

    func loadItems() {
        itemsCollectionView.reloadData()
    }
    
    func askRUT() {
        let alert = UIAlertController(title: String.Alert.title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String.Alert.cancel, style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = String.Alert.placeholder
        })
        alert.addAction(UIAlertAction(title: String.Alert.ok, style: .default, handler: { action in
            let rut = alert.textFields?.first?.text
            self.presenter.searchRUT(rut: rut)
        }))
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionView

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.className, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUp(item: presenter.items[indexPath.row])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(indexPath: indexPath)
    }
}

