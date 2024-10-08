//
//  SwiftChartBasics.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import Charts
import SwiftUI

struct SwiftChartBasics: View {
    var body: some View {
//        Chart {
//            ForEach(sales) { element in
//                BarMark(
//                    x: .value("Name", element.sales),
//                    y: .value("Sales", element.name)
//                )
//            }
//        }
//        .frame(width: 350, height: 350)

// instead of doing like above, you can use the Chart itself replacing the for each:
        Chart(sales) { element in
            BarMark(
                x: .value("Name", element.sales),
                y: .value("Sales", element.name)
            )
        }
        .frame(width: 350, height: 350)

// you can swap the x and y value to switch from vertical view as needed
    }
}

#Preview {
    SwiftChartBasics()
}
