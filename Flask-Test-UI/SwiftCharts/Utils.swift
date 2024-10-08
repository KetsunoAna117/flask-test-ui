//
//  Utils.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import Foundation

enum City {
    case cupertino
    case sanFrancisco
}

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    let calendar = Calendar.current
    let components = DateComponents(year: year, month: month, day: day)
    return calendar.date(from: components) ?? Date() // Provide a fallback date in case the components are invalid
}
