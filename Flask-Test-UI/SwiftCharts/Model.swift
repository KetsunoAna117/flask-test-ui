//
//  Data.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import Foundation

struct Pancakes: Identifiable {
    var name: String
    var sales: Int
    var id: String{ name }
}

struct SalesSummary: Identifiable {
    let weekday: Date
    let sales: Int
    
    var id: Date { weekday }
}

struct Series: Identifiable {
    let city: String
    let sales: [SalesSummary]
    
    var id: String { city }
}
