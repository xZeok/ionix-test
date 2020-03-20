//
//  HomePresenter.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation


protocol HomePresenterLogic: class {
    var items: [Item] { get }
    func getItems()
}

class HomePresenter {
    
    // MARK: - Properties.
    
    weak var view: HomeViewControllerLogic?
    
    // MARK: - Private properties.
    
    private let model: HomeModelLogic
    private(set) var items = [Item]()
    
    // MARK: - Initializers.
    
    init(_ model: HomeModel) {
        self.model = model
    }
}

// MARK: - ListPresenterLogic.

extension HomePresenter: HomePresenterLogic {
    
    func getItems() {
        self.model.getItems { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                self.view?.loadItems()
            case .failure(let error):
                print(error)
            }
        }
    }
}

