//
//  BarGraph+Picker.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 08/10/24.
//

import SwiftUI
import Charts

struct BarGraph_Picker: View {
    @State var city: City = .cupertino
    
    var data: [SalesSummary] {
        switch city {
        case .cupertino:
            return cupertinoData
        case .sanFrancisco:
            return sfData
        }
    }
    
    var body: some View {
        // Swift chart also works with animation called from the picker function as can be seen below
        VStack {
            Picker("City", selection: $city.animation(.easeInOut)) {
                Text("Cupertino").tag(City.cupertino)
                Text("San Francisco").tag(City.sanFrancisco)
            }
            .pickerStyle(.segmented)
            
            Chart(data) { element in
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
    
        }
        .frame(width: 350, height: 350)
    }
}

#Preview {
    BarGraph_Picker()
}
