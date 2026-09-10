import SwiftUI
import MapKit

struct MondayRouteSelectionView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    NavigationLink {
                        MondayRouteView(
                            routeNumber: 1
                        )
                    } label: {
                        RouteSelectionRow(
                            routeNumber: 1,
                            stopCount: 19,
                            description: "Jantz → Cecilia"
                        )
                    }
                    
                    NavigationLink {
                        MondayRouteView(
                            routeNumber: 2
                        )
                    } label: {
                        RouteSelectionRow(
                            routeNumber: 2,
                            stopCount: 15,
                            description: "Douglas Beck → Rushing"
                        )
                    }
                }
                
                Section {
                    Text("Each route follows the exact order you provided.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Monday Routes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct RouteSelectionRow: View {
    
    let routeNumber: Int
    let stopCount: Int
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image(systemName: "map.fill")
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 35)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Route \(routeNumber)")
                    .font(.headline)
                
                Text("\(stopCount) stops")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    MondayRouteSelectionView()
}
