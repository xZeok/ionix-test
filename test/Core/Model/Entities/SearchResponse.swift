//
//  SearchResponse.swift
//  test
//
//  Created by Jaime Capponi on 20-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation


public struct SearchResponse: Codable {
    var responseCode: Int
    var description: String
    var result: SearchResult
}

struct SearchResult: Codable {
    var items: [PersonData]
}

struct PersonData: Codable {
    var name: String
    var detail: PersonDetail
}

struct PersonDetail: Codable {
    var email: String
    var phoneNumber: String
}

extension PersonDetail {
    enum CodingKeys: String, CodingKey {
        case email
        case phoneNumber = "phone_number"
    }
}
