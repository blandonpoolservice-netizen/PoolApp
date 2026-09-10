//
//  DayRouteSelectorView.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/6/26.
//


import SwiftUI

struct DayRouteSelectorView: View {
    
    let day: String
    
    var body: some View {
        switch day {
        case "Monday":
            MondayRouteSelectionView()
        case "Tuesday":
            TuesdayRouteView(routeNumber: 1)
        case "Wednesday":
            Text("Wednesday route coming soon")
        case "Thursday":
            Text("Thursday route coming soon")
        default:
            Text("No route scheduled for today.")
        }
    }
}
