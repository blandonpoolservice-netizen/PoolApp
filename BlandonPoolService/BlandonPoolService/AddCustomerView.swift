import SwiftUI
import SwiftData

struct AddCustomerView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext)
    private var modelContext
    
    @State private var name = ""
    @State private var address = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var serviceType = "Full Service"
    @State private var serviceDay = "Monday"
    @State private var monthlyPrice = ""
    
    private let serviceDays = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "sunday"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Customer Information") {
                    TextField(
                        "Customer Name",
                        text: $name
                    )
                    
                    TextField(
                        "Address",
                        text: $address
                    )
                    
                    TextField(
                        "Phone",
                        text: $phone
                    )
                    
                    TextField(
                        "Email",
                        text: $email
                    )
                    .keyboardType(.emailAddress)
                }
                
                Section("Service") {
                    Picker(
                        "Service Type",
                        selection: $serviceType
                    ) {
                        Text("Full Service")
                            .tag("Full Service")
                        
                        Text("Chemical Service")
                            .tag("Chemical Service")
                    }
                    
                    Picker(
                        "Service Day",
                        selection: $serviceDay
                    ) {
                        ForEach(serviceDays, id: \.self) { day in
                            Text(day)
                                .tag(day)
                        }
                    }
                    
                    TextField(
                        "Monthly Price",
                        text: $monthlyPrice
                    )
                    .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("New Customer")
            .toolbar {
                
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Save") {
                        saveCustomer()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespaces
                        ).isEmpty
                    )
                }
                
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveCustomer() {
        let price = Double(monthlyPrice) ?? 0
        
        let customer = Customer(
            name: name,
            address: address,
            phone: phone,
            email: email,
            serviceType: serviceType,
            serviceDay: serviceDay,
            monthlyPrice: price
        )
        
        modelContext.insert(customer)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save customer: \(error)")
        }
    }
}

#Preview {
    AddCustomerView()
        .modelContainer(
            for: Customer.self,
            inMemory: true
        )
}
