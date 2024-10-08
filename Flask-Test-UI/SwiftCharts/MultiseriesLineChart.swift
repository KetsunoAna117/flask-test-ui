//
//  MultiseriesLineChart.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import SwiftUI
import Charts

struct MultiseriesLineChart: View {
    var body: some View {
//        Chart(seriesData) { series in
//            ForEach(series.sales) { element in
//                BarMark( // change this into PointMark, LineMark which is also an available option
//                    x: .value("Day", element.weekday, unit: .day),
//                    y: .value("Sales", element.sales)
//                )
//                .foregroundStyle(by: .value("City", series.city))
//            }
//        }
//        .chartXAxis {
//            AxisMarks(values: .stride(by: .day)) { value in
//                if value.as(Date.self) != nil {
//                    AxisGridLine()
//                    AxisTick()
//                    AxisValueLabel(format: .dateTime.weekday(), centered: true)
//                }
//            }
//        }
//        .frame(width: 350, height: 350)
        
        
        // This is an example of combined chart series
//        Chart(seriesData) { series in
//            ForEach(series.sales) { element in
//                LineMark(
//                    x: .value("Day", element.weekday, unit: .day),
//                    y: .value("Sales", element.sales)
//                )
//                .foregroundStyle(by: .value("City", series.city))
//                
//                PointMark(
//                    x: .value("Day", element.weekday, unit: .day),
//                    y: .value("Sales", element.sales)
//                )
//                .foregroundStyle(by: .value("City", series.city))
//                .symbol(by: .value("City", series.city)) // differentiate based on symbol
//            }
//        }
//        .chartXAxis {
//            AxisMarks(values: .stride(by: .day)) { value in
//                if value.as(Date.self) != nil {
//                    AxisGridLine()
//                    AxisTick()
//                    AxisValueLabel(format: .dateTime.weekday(), centered: true)
//                }
//            }
//        }
//        .frame(width: 350, height: 350)
        
        
        // The below is the exact same as the combined chart series above, but using shorthand available in the Charts library, the style of points adapt the line
        Chart(seriesData) { series in
            ForEach(series.sales) { element in
                LineMark(
                    x: .value("Day", element.weekday, unit: .day),
                    y: .value("Sales", element.sales)
                )
                .foregroundStyle(by: .value("City", series.city))
                .symbol(by: .value("City", series.city)) // differentiate based on symbol
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                if value.as(Date.self) != nil {
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.weekday(), centered: true)
                }
            }
        }
        .frame(width: 350, height: 350)
        
    }
}

#Preview {
    MultiseriesLineChart()
}
