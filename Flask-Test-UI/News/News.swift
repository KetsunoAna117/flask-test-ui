//
//  News.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 02/10/24.
//

import Foundation

struct News: Codable {
    var newsID: Int
    var stockID: Int
    var description: String
    var valueFluctuation: Int
    
    enum CodingKeys: String, CodingKey {
        case newsID = "news_id"
        case stockID = "stock_id"
        case description = "news_description"
        case valueFluctuation = "news_val_fluks"
    }
}
