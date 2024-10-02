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
        case name = "kode_name"
        case price = "total_shares"
    }
}
