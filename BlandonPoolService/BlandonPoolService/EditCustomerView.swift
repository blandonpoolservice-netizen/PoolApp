import SwiftUI
import SwiftData

struct EditCustomerView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext)
    private var modelContext
    
    let customer: Customer
    
    @State private var name: String
    @State private var address: String
    @State private var phone: String
    @State private var email: String
    @State private var serviceType: String
    @State private var serviceDay: String
    @State private var monthlyPrice: String
    @State private var outstandingBalance: String
    @State private var paymentHandle: String
    @State private var notes: String
    
    private let serviceDays = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    ]
    
    init(customer: Customer) {
        self.customer = customer
        
        _name = State(initialValue: customer.name)
        _address = State(initialValue: customer.address)
        _phone = State(initialValue: customer.phone)
        _email = State(initialValue: customer.email)
        _serviceType = State(initialValue: customer.serviceType)
        _serviceDay = State(
            initialValue: customer.serviceDay ?? "Monday"
        )
        _monthlyPrice = State(
            initialValue: String(customer.monthlyPrice)
        )
        _outstandingBalance = State(
            initialValue: String(
                customer.outstandingBalance ?? 0
            )
        )
        _paymentHandle = State(
            initialValue: customer.paymentHandle ?? ""
        )
        _notes = State(
            initialValue: customer.notes ?? ""
        )
    }
    
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
                        ForEach(
                            serviceDays,
                            id: \.self
                        ) { day in
                            Text(day)
                                .tag(day)
                        }
                    }
                    
                    TextField(
                        "Monthly Fee",
                        text: $monthlyPrice
                    )
                    .keyboardType(.decimalPad)
                }
                
                Section("Account") {
                    TextField(
                        "Outstanding Balance",
                        text: $outstandingBalance
                    )
                    .keyboardType(.decimalPad)
                    
                    TextField(
                        "Payment Handle",
                        text: $paymentHandle
                    )
                    
                    TextField(
                        "Notes",
                        text: $notes,
                        axis: .vertical
                    )
                    .lineLimit(3...6)
                }
            }
            .navigationTitle("Edit Customer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Save") {
                        saveChanges()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespaces
                        ).isEmpty
                    )
                }
            }
        }
    }
    
    private func saveChanges() {
        customer.name = name
        customer.address = address
        customer.phone = phone
        customer.email = email
        customer.serviceType = serviceType
        customer.serviceDay = serviceDay
        customer.monthlyPrice = Double(monthlyPrice) ?? 0
        
        if let balance = Double(outstandingBalance) {
            customer.outstandingBalance = balance
        } else {
            customer.outstandingBalance = nil
        }
        
        customer.paymentHandle =
            paymentHandle.isEmpty ? nil : paymentHandle
        
        customer.notes =
            notes.isEmpty ? nil : notes
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save customer: \(error)")
        }
    }
}//
//  EditCustomerView.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//

