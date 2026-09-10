import SwiftUI
import SwiftData

struct CustomerDetailView: View {
    
    let customer: Customer
    
    var body: some View {
        Form {
            
            Section("Customer Information") {
                
                HStack {
                    Text("Name")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(customer.name)
                }
                
                if !customer.address.isEmpty {
                    HStack {
                        Text("Address")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(customer.address)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                if !customer.phone.isEmpty {
                    HStack {
                        Text("Phone")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(customer.phone)
                    }
                }
                
                if !customer.email.isEmpty {
                    HStack {
                        Text("Email")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(customer.email)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Section("Service") {
                
                HStack {
                    Text("Service Type")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(customer.serviceType)
                }
                
                if let serviceDay = customer.serviceDay {
                    HStack {
                        Text("Service Day")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(serviceDay)
                    }
                }
                
                HStack {
                    Text("Monthly Fee")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(
                        customer.monthlyPrice,
                        format: .currency(code: "USD")
                    )
                    .fontWeight(.semibold)
                }
            }
            
            Section("Account") {
                
                if let balance = customer.outstandingBalance {
                    HStack {
                        Text("Outstanding")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(
                            balance,
                            format: .currency(code: "USD")
                        )
                        .fontWeight(.semibold)
                    }
                }
                
                if let paymentHandle = customer.paymentHandle,
                   !paymentHandle.isEmpty {
                    
                    HStack {
                        Text("Payment")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(paymentHandle)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                if let notes = customer.notes,
                   !notes.isEmpty {
                    
                    HStack {
                        Text("Notes")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Section("Payments") {
                
                if customer.payments.isEmpty {
                    
                    Text("No payments recorded.")
                        .foregroundStyle(.secondary)
                    
                } else {
                    
                    ForEach(
                        customer.payments.sorted {
                            $0.paymentDate > $1.paymentDate
                        }
                    ) { payment in
                        
                        VStack(
                            alignment: .leading,
                            spacing: 5
                        ) {
                            
                            HStack {
                                Text(
                                    payment.amount,
                                    format: .currency(code: "USD")
                                )
                                .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text(payment.month)
                            }
                            
                            HStack {
                                Text(payment.paymentMethod)
                                
                                Spacer()
                                
                                Text(
                                    payment.paymentDate,
                                    format: .dateTime
                                        .month(.abbreviated)
                                        .day()
                                        .year()
                                )
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle(customer.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditCustomerView(customer: customer)
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}

#Preview {
    CustomerDetailView(
        customer: Customer(
            name: "Test Customer",
            serviceDay: "Monday",
            monthlyPrice: 195,
            outstandingBalance: 10,
            paymentHandle: "@test",
            notes: "Test notes"
        )
    )
    .modelContainer(
        for: [
            Customer.self,
            Payment.self
        ],
        inMemory: true
    )
}
