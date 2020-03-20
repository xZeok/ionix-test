//
//  DataTypes.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation

// MARK: - Callbacks

public typealias Callback = () -> Void
public typealias CallbackItems = (Result<[Item], APIManager.ServiceError>) -> Void
public typealias CallbackSearch = (Result<SearchResponse, APIManager.ServiceError>) -> Void

// MARK: - Others

public typealias Parameters = [String: Any]

