//
//  HomeModel.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation

protocol HomeModelLogic: class {
    func getItems(_ completion: @escaping CallbackItems)
    func searchRUT(rut: String, _ completion: @escaping CallbackSearch)
}

class HomeModel: HomeModelLogic {

    // MARK: - Private properties.
    
    private(set) var items = [Item]()
    
    // MARK: - ListModelLogic.
    
    func getItems(_ completion: @escaping CallbackItems) {
        APIManager.shared.request(router: Router.getItems, generic: [[Item]].self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                var newItems = [Item]()
                for array in data {
                    for item in array {
                        newItems.append(item)
                    }
                }
                self.items = newItems
                completion(.success(self.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchRUT(rut: String, _ completion: @escaping CallbackSearch) {
        APIManager.shared.request(router: Router.searchRUT(parameters: ["rut": rut]), generic: SearchResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


