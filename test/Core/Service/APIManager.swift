//
//  APIManager.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation
import Alamofire

public class APIManager {
    
    static let shared = APIManager()
    
    // MARK: - Private properties.
    
    private var manager = SessionManager()
    
    // MARK: - API Service Errors.
    
    public enum ServiceError: Error {
        case invalidResponse
        case noParameters
        case noData
        case decodeError
    }
    
    // MARK: - Initializer.
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        configuration.httpCookieStorage = nil
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // MARK: - Public functions.
    
    func request<T: Codable>(router: Router, generic: T.Type, completion: @escaping (Swift.Result<T, ServiceError>) -> ()) {
        manager.request(router)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(.noData))
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(generic, from: data)
                        print(response)
                        completion(.success(response))
                    } catch {
                        print("DECODE ERROR")
                        completion(.failure(.decodeError))
                    }
                case .failure:
                    print("DECODE ERROR")
                    completion(.failure(.invalidResponse))
                }
        }
    }
}
