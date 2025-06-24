//
//  APIObject.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation

struct APIObjectResponse: Codable {
    let id: String
    let name: String
    let data: [String: AnyCodable]?
    
    var dataDescription: String {
        guard let data else { return "" }
        return data.map { "\($0): \($1.value)" }
            .joined(separator: ", ")
    }
}
