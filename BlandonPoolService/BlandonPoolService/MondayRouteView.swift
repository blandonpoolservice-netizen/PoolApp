import SwiftUI
import MapKit

struct MondayRouteView: View {
    
    let routeNumber: Int
    
    @State private var completedStops: Set<String> = []
    
    var stops: [RouteStop] {
        routeNumber == 1 ? route1Stops : route2Stops
    }
    
    var body: some View {
        List {
            
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Route \(routeNumber)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(stops.count) stops")
                        .foregroundStyle(.secondary)
                    
                    ProgressView(
                        value: Double(completedStops.count),
                        total: Double(stops.count)
                    )
                    
                    Text(
                        "\(completedStops.count) of \(stops.count) completed"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }
            
            Section("Stops") {
                
                ForEach(
                    Array(stops.enumerated()),
                    id: \.element.id
                ) { index, stop in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack {
                            
                            Text("\(index + 1)")
                                .font(.headline)
                                .frame(width: 30, height: 30)
                                .background(
                                    completedStops.contains(stop.id)
                                    ? Color.green
                                    : Color.blue
                                )
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                            
                            VStack(
                                alignment: .leading,
                                spacing: 3
                            ) {
                                
                                Text(stop.name)
                                    .font(.headline)
                                
                                Text(stop.address)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Button {
                                toggleCompleted(stop)
                            } label: {
                                Image(
                                    systemName:
                                        completedStops.contains(stop.id)
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .font(.title2)
                                .foregroundStyle(
                                    completedStops.contains(stop.id)
                                    ? .green
                                    : .secondary
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                openNavigation(for: stop)
                            } label: {
                                Label(
                                    "Navigate",
                                    systemImage: "location.fill"
                                )
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Monday Route \(routeNumber)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleCompleted(
        _ stop: RouteStop
    ) {
        if completedStops.contains(stop.id) {
            completedStops.remove(stop.id)
        } else {
            completedStops.insert(stop.id)
        }
    }
    
    private func openNavigation(
        for stop: RouteStop
    ) {
        let encodedAddress =
            stop.address.addingPercentEncoding(
                withAllowedCharacters:
                    .urlQueryAllowed
            ) ?? stop.address
        
        if let url = URL(
            string:
                "http://maps.apple.com/?q=\(encodedAddress)"
        ) {
            UIApplication.shared.open(url)
        }
    }
}


// MARK: - Route Stop Model

struct RouteStop: Identifiable {
    
    let id: String
    let name: String
    let address: String
}


// MARK: - Monday Route 1

let route1Stops: [RouteStop] = [
    
    RouteStop(
        id: "jantz",
        name: "Jantz",
        address: "2240 Oak Crest Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "anthoy-perez",
        name: "Anthoy Perez",
        address: "4218 Montara Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "smith",
        name: "Smith",
        address: "931 Ashford Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "younen",
        name: "Thomas Younen",
        address: "3690 N Olive Ave, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "martin-macias",
        name: "Martin Macias",
        address: "963 Dancer Way, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "pratt",
        name: "Pratt",
        address: "4653 Tapestry Way, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "marion-sangar",
        name: "Marion Sangar",
        address: "1874 Edgewood Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "black",
        name: "Black",
        address: "908 Carolyn Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "melissa-peacock",
        name: "Melissa - Peacock",
        address: "1705 Peacock Dr, Turlock, CA 95382"
    ),
    
    RouteStop(
        id: "orozco",
        name: "Orozco",
        address: "4110 Valkommen Dr, Denair, CA 95316"
    ),
    
    RouteStop(
        id: "fereira",
        name: "Fereira",
        address: "2220 Christine Way, Delhi, CA 95389"
    ),
    
    RouteStop(
        id: "melissa-marshall",
        name: "Melissa - Marshall",
        address: "1321 E Marshall St, Turlock, CA 95380"
    ),
    
    RouteStop(
        id: "bryan-perez",
        name: "Bryan Perez",
        address: "952 Ninth St, Turlock, CA 95380"
    ),
    
    RouteStop(
        id: "calvin",
        name: "Calvin",
        address: "20488 Sapphire Ct, Delhi, CA 95324"
    ),
    
    RouteStop(
        id: "bruce",
        name: "Bruce",
        address: "10116 Earl St, Delhi, CA 95324"
    ),
    
    RouteStop(
        id: "nixon",
        name: "Nixon",
        address: "8192 Golf Link Rd, Delhi, CA 95324"
    ),
    
    RouteStop(
        id: "betty",
        name: "Betty",
        address: "10995 El Capitan Way, Ballico, CA 95303"
    ),
    
    RouteStop(
        id: "cristal",
        name: "Cristal",
        address: "11150 Merced Ave, Turlock, CA 95380"
    ),
    
    RouteStop(
        id: "cecilia",
        name: "Cecilia",
        address: "11245 Merced Ave, Turlock, CA 95380"
    )
]


// MARK: - Monday Route 2

let route2Stops: [RouteStop] = [
    
    RouteStop(
        id: "douglas-beck",
        name: "Douglas Beck",
        address: "6619 River Rd, Oakdale, CA 95361"
    ),
    
    RouteStop(
        id: "jeff-burns",
        name: "Jeff Burns",
        address: "6343 River Rd, Oakdale, CA 95361"
    ),
    
    RouteStop(
        id: "desacampos",
        name: "Desacampos",
        address: "1605 Sophie Ln, Escalon, CA 95320"
    ),
    
    RouteStop(
        id: "mckensie",
        name: "Mckensie",
        address: "4321 Lourmarin Ln, Modesto, CA 95356"
    ),
    
    RouteStop(
        id: "miguel",
        name: "Miguel (Maribel Zamora)",
        address: "605 Ancestry Way, Modesto, CA 95356"
    ),
    
    RouteStop(
        id: "richard-vanden-bosch",
        name: "Richard Vanden Bosch",
        address: "412 Greenwich Ln, Modesto, CA 95350"
    ),
    
    RouteStop(
        id: "patricia",
        name: "Patricia",
        address: "201 Raven Ct, Modesto, CA 95350"
    ),
    
    RouteStop(
        id: "bowman",
        name: "Bowman",
        address: "1426 Queens Ave, Modesto, CA 95355"
    ),
    
    RouteStop(
        id: "fraze",
        name: "Fraze",
        address: "609 Brookvale Dr, Modesto, CA 95355"
    ),
    
    RouteStop(
        id: "jessica-rodriguez",
        name: "Jessica Rodriguez",
        address: "1008 Zinfandel Pl, Modesto, CA 95351"
    ),
    
    RouteStop(
        id: "mrs-yee",
        name: "Mrs. Yee",
        address: "661 Wellsford Rd, Modesto, CA 95357"
    ),
    
    RouteStop(
        id: "upchurch",
        name: "Upchurch",
        address: "1708 Burlwood Ct, Ceres, CA 95326"
    ),
    
    RouteStop(
        id: "mr-star",
        name: "Mr. Star",
        address: "6424 Roeding Rd, Hughson, CA 95326"
    ),
    
    RouteStop(
        id: "veronica",
        name: "Veronica",
        address: "4136 Esmar Rd, Keyes, CA 95328"
    ),
    
    RouteStop(
        id: "rushing",
        name: "Rushing",
        address: "4591 Fulkerth Rd, Turlock, CA 95380"
    )
]


#Preview {
    NavigationStack {
        MondayRouteView(
            routeNumber: 1
        )
    }
}
