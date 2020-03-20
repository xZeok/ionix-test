//
//  HomeFactory.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import UIKit

class HomeFactory {
    
    func getHomeViewController() -> UIViewController {
        let presenter = HomePresenter(HomeModel())
        let viewController = HomeViewController(presenter)
        presenter.view = viewController
        return viewController
    }
}
