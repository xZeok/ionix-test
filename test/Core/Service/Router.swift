//
//  Router.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
    
    case getItems
    case searchRUT(parameters: Parameters)
    
    var baseURL: String {
        switch self {
        case .getItems:
            return "https://api.myjson.com"
        default:
            return "https://sandbox.ionix.cl"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getItems, .searchRUT:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getItems:
            return "/bins/h3ayu"
        case .searchRUT:
            return "/test-tecnico/search"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchRUT(let params):
            return params
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        return try URLEncoding.default.encode(request, with: parameters)
    }
}


