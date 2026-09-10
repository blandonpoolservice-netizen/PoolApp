import SwiftUI
import SwiftData

struct CustomerListView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(
        sort: \Customer.name
    )
    private var customers: [Customer]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(customers) { customer in
                    NavigationLink {
                        CustomerDetailView(
                            customer: customer
                        )
                    } label: {
                        VStack(alignment: .leading) {
                            
                            Text(customer.name)
                                .font(.headline)
                            
                            Text(customer.address)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text(customer.serviceType)
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .onDelete(
                    perform: deleteCustomers
                )
            }
            .navigationTitle("Customers")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddCustomerView()
                    } label: {
                        Image(
                            systemName: "plus"
                        )
                    }
                }
            }
        }
    }
    
    private func deleteCustomers(
        at offsets: IndexSet
    ) {
        for index in offsets {
            modelContext.delete(
                customers[index]
            )
        }
    }
}

#Preview {
    CustomerListView()
        .modelContainer(
            for: [
                Customer.self,
                Payment.self
            ],
            inMemory: true
        )
}
