import SwiftUI
import SwiftData
import MapKit

struct DashboardView: View {
    
    @Environment(\.modelContext)
    private var modelContext

    @Query
    private var customers: [Customer]
    
    @State private var showingRouteSelection = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Header
                    
                    VStack(spacing: 8) {
                        Text("Blandon's Pool Service")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Today's Route")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top)
                    
                    // MARK: - Dashboard Cards
                    
                    HStack {
                        DashboardCard(
                            title: "Customers",
                            value: "\(customers.count)",
                            icon: "person.3.fill"
                        )
                        
                        DashboardCard(
                            title: "Stops",
                            value: "34",
                            icon: "mappin.and.ellipse"
                        )
                    }
                    
                    // MARK: - Route Section
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Today's Route")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Tap below to start your route for today.")
                            .foregroundStyle(.secondary)
                        
                        Button {
                            showingRouteSelection = true
                        } label: {
                            Label(
                                "Start Day Route",
                                systemImage: "location.fill"
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                    
                    // MARK: - System Status
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("System Status")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            
                            Text("Customer database connected")
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            
                            Text("Payment system connected")
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundStyle(.blue)
                            
                            Text("GPS route system ready")
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .sheet(isPresented: $showingRouteSelection) {
                DayRouteSelectorView(day: Date().weekdayName)
            }
        }
    }
}

struct DashboardCard: View {
    
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(.blue)
            
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(title)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    DashboardView()
        .modelContainer(
            for: [
                Customer.self,
                Payment.self
            ],
            inMemory: true
        )
}
// TEMP: test extension here
//extension Date {
  //  var weekdayName: String {
       // let formatter = DateFormatter()
        //formatter.dateFormat = "EEEE"
        //return formatter.string(from: self)
   // }
//}
