import SwiftUI
import MapKit

struct TuesdayRouteView: View {
    
    let routeNumber: Int
    
    @State private var completedStops: Set<String> = []
    
    var stops: [RouteStop] {
        tuesdayRouteStops
    }
    
    var body: some View {
        List {
            
            // MARK: - Header
            
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Tuesday Route \(routeNumber)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(stops.count) stops")
                        .foregroundStyle(.secondary)
                    
                    ProgressView(
                        value: Double(completedStops.count),
                        total: Double(stops.count)
                    )
                    
                    Text("\(completedStops.count) of \(stops.count) completed")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }
            
            // MARK: - Stops
            
            Section("Stops") {
                ForEach(Array(stops.enumerated()), id: \.element.id) { index, stop in
                    
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
                            
                            VStack(alignment: .leading, spacing: 3) {
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
                                Label("Navigate", systemImage: "location.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Tuesday Route \(routeNumber)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleCompleted(_ stop: RouteStop) {
        if completedStops.contains(stop.id) {
            completedStops.remove(stop.id)
        } else {
            completedStops.insert(stop.id)
        }
    }
    
    private func openNavigation(for stop: RouteStop) {
        let encodedAddress = stop.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? stop.address
        
        if let url = URL(string: "http://maps.apple.com/?q=\(encodedAddress)") {
            UIApplication.shared.open(url)
        }
    }
}


// MARK: - Tuesday Route Stops (Correct Addresses)

    let tuesdayRouteStops: [RouteStop] = [

        RouteStop(id: "juan-vergara", name: "Juan Vergara",
                  address: "7873 West Depot Master Drive, Mountain House, CA 95304"),

        RouteStop(id: "stopka", name: "Stopka",
                  address: "8799 Waterwell Way, Tracy, CA 95304"),

        RouteStop(id: "zara-basel", name: "Zara Basel",
                  address: "8336 Park Place, Tracy, CA 95304"),

        RouteStop(id: "kim-hong", name: "Kim Hong",
                  address: "8324 Park Place, Tracy, CA 95304"),

        RouteStop(id: "katie-kovenich", name: "Katie Kovenich",
                  address: "1561 Biarritz St, Tracy, CA 95304"),

        RouteStop(id: "mary-napoli", name: "Mary Napoli",
                  address: "1486 Montauban Ct, Tracy, CA 95304"),

        RouteStop(id: "eva-obrian", name: "Eva Obrian",
                  address: "1466 Montauban Ct, Tracy, CA 95304"),

        RouteStop(id: "suman", name: "Suman",
                  address: "1171 Dominique Dr, Tracy, CA 95304"),

        RouteStop(id: "alberto-sabrina", name: "Alberto and Sabrina",
                  address: "1180 Dominique Dr, Tracy, CA 95304"),

        RouteStop(id: "loriane", name: "Loriane",
                  address: "4845 Dandelion Loop, Tracy, CA 95377"),

        RouteStop(id: "kim-simmons", name: "Kim Simmons",
                  address: "1495 Tom Fowler Dr, Tracy, CA 95377"),

        RouteStop(id: "summer", name: "Summer",
                  address: "1222 Riverview Ave, Tracy, CA 95377"),

        RouteStop(id: "ramzia-kakar", name: "Ramzia Kakar",
                  address: "6783 Ishan St, Tracy, CA 95377"),

        RouteStop(id: "gerald", name: "Gerald (Tanty)",
                  address: "1721 Shantz Way, Tracy, CA 95376"),

        RouteStop(id: "tiffany-baker", name: "Tiffany Baker",
                  address: "2884 Brantford Ct, Tracy, CA 95377"),

        RouteStop(id: "claudia-garcia", name: "Claudia Garcia (Jorge)",
                  address: "1780 Birchwood Lane, Tracy, CA 95376"),

        RouteStop(id: "cesar-mnt", name: "Cesar Mnt House",
                  address: "971 S Terra Oro Ct, Mountain House, CA 95391"),

        RouteStop(id: "yolanda", name: "Yolanda",
                  address: "393 E Huntley Ave, Mountain House, CA 95391")
    ]

    

