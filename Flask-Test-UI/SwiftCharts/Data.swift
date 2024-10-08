//
//  Data.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import Foundation

let sales: [Pancakes] = [
    .init(name: "Cachapa", sales: 916),
    .init(name: "Injera", sales: 850),
    .init(name: "Crepe", sales: 802),
    .init(name: "Jian Bing", sales: 753),
    .init(name: "Dosa", sales: 654),
    .init(name: "American", sales: 618),
]

let cupertinoData: [SalesSummary] = [
    // Monday
    .init(weekday: date(2022, 5, 2), sales: 54),
    // Tuesday
    .init(weekday: date(2022, 5, 3), sales: 42),
    // Wednesday
    .init(weekday: date(2022, 5, 4), sales: 88),
    // Thursday
    .init(weekday: date(2022, 5, 5), sales: 49),
    // Friday
    .init(weekday: date(2022, 5, 6), sales: 42),
    // Saturday
    .init(weekday: date(2022, 5, 7), sales: 125),
    // Sunday
    .init(weekday: date(2022, 5, 8), sales: 67)
]

let sfData: [SalesSummary] = [
    // Monday
    .init(weekday: date(2022, 5, 2), sales: 81),
    // Tuesday
    .init(weekday: date(2022, 5, 3), sales: 90),
    // Wednesday
    .init(weekday: date(2022, 5, 4), sales: 52),
    // Thursday
    .init(weekday: date(2022, 5, 5), sales: 72),
    // Friday
    .init(weekday: date(2022, 5, 6), sales: 84),
    // Saturday
    .init(weekday: date(2022, 5, 7), sales: 84),
    // Sunday
    .init(weekday: date(2022, 5, 8), sales: 137)
]

let seriesData: [Series] = [
    .init(city: "Cupertino", sales: cupertinoData),
    .init(city: "San Francisco", sales: sfData)
]
