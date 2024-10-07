//
//  Person.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 29/09/24.
//

import Foundation

struct Stock: Codable {
    var name: String
    var price: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price"
    }
}
