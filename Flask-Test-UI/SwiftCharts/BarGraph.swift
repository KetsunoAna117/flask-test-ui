//
//  BarGraph.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import SwiftUI
import Charts

struct BarGraph: View {
    var body: some View {
        Chart(cupertinoData) { element in
            BarMark(
                x: .value("Day", element.weekday, unit: .day),
                y: .value("Sales", element.sales)
            )
        }
        // lah anjir co knp harus ada chartXAxis anjir, di WWDC tydak begitu :(
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                if value.as(Date.self) != nil {
                    AxisGridLine() // grid line nya
                    AxisTick() // pemisah di bawah day of week
                    AxisValueLabel(format: .dateTime.weekday(), centered: true) // Display the day of the week (e.g., "Mon", "Tue")
                }
            }
        }
        .frame(width: 350, height: 350)

    }
}

#Preview {
    BarGraph()
}
