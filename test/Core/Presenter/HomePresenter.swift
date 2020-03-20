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
    func selectItem(indexPath: IndexPath)
    func searchRUT(rut: String?)
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
        view?.showLoading(loading: true)
        self.model.getItems { [weak self] (result) in
            guard let self = self else { return }
            self.view?.showLoading(loading: false)
            switch result {
            case .success(let items):
                self.items = items
                self.view?.loadItems()
            case .failure:
                self.view?.showAlert(text: String.Error.request) {
                    self.getItems()
                }
            }
        }
    }
    
    func selectItem(indexPath: IndexPath) {
        if indexPath.row == 0 {
            view?.askRUT()
        }
    }
    
    func searchRUT(rut: String?) {
        guard let rut = rut, rut != "" else {
            view?.showAlert(text: String.Error.noRUT) {}
            return
        }
        view?.showLoading(loading: true)
        self.model.searchRUT(rut: DES().encrypt(rut)) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.view?.showLoading(loading: false)
            switch result {
            case .success(let response):
                let items = response.result.items
                if items.count > 0 {
                    var message = ""
                    for element in items {
                        message.append("\(element.detail.email) \(element.detail.phoneNumber)\n")
                    }
                    self.view?.showAlert(text: message) {}
                } else {
                    self.view?.showAlert(text: String.Error.noInformation) {}
                }
            case .failure:
                self.view?.showAlert(text: String.Error.request) {}
            }
        }
    }
}

