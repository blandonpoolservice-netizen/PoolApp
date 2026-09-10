//
//  AddPaymentView.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//
import SwiftUI
import SwiftData

struct AddPaymentView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(sort: \Customer.name)
    private var customers: [Customer]
    
    @State private var selectedCustomer: Customer?
    @State private var amount = ""
    @State private var paymentMethod = "Cash"
    @State private var month = "September"
    @State private var paymentDate = Date()
    
    private let paymentMethods = [
        "Cash",
        "Venmo",
        "Zelle",
        "Bank",
        "Apple Cash"
    ]
    
    private let months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Customer") {
                    Picker(
                        "Customer",
                        selection: $selectedCustomer
                    ) {
                        Text("Select Customer")
                            .tag(nil as Customer?)
                        
                        ForEach(customers) { customer in
                            Text(customer.name)
                                .tag(customer as Customer?)
                        }
                    }
                }
                
                Section("Payment") {
                    TextField(
                        "Amount",
                        text: $amount
                    )
                    .keyboardType(.decimalPad)
                    
                    Picker(
                        "Payment Method",
                        selection: $paymentMethod
                    ) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method)
                                .tag(method)
                        }
                    }
                    
                    Picker(
                        "Month Paid",
                        selection: $month
                    ) {
                        ForEach(months, id: \.self) { month in
                            Text(month)
                                .tag(month)
                        }
                    }
                    
                    DatePicker(
                        "Payment Date",
                        selection: $paymentDate,
                        displayedComponents: .date
                    )
                }
            }
            .navigationTitle("New Payment")
            .toolbar {
                
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Save") {
                        savePayment()
                    }
                    .disabled(
                        selectedCustomer == nil ||
                        Double(amount) == nil
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
    
    private func savePayment() {
        guard let customer = selectedCustomer,
              let paymentAmount = Double(amount) else {
            return
        }
        
        let payment = Payment(
            amount: paymentAmount,
            paymentMethod: paymentMethod,
            month: month,
            paymentDate: paymentDate,
            customer: customer
        )
        
        modelContext.insert(payment)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save payment: \(error)")
        }
    }
}

#Preview {
    AddPaymentView()
        .modelContainer(
            for: [
                Customer.self,
                Payment.self
            ],
            inMemory: true
        )
}
