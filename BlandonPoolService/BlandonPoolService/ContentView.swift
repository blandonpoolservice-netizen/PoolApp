import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            DashboardView()
                .tabItem {
                    Label("Today", systemImage: "house.fill")
                }

            CustomerListView()
                .tabItem {
                    Label("Customers", systemImage: "person.3.fill")
                }

            PaymentsView()
                .tabItem {
                    Label("Payments", systemImage: "dollarsign.circle.fill")
                }

            NavigationStack {
                DataManagementView()
            }
            .tabItem {
                Label("More", systemImage: "gearshape.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}

