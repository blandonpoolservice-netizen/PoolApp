//
//  PaymentsView.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//


import SwiftUI
import SwiftData

struct PaymentsView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(
        sort: \Payment.paymentDate,
        order: .reverse
    )
    private var payments: [Payment]
    
    @State private var showingAddPayment = false
    
    var body: some View {
        NavigationStack {
            List {
                if payments.isEmpty {
                    ContentUnavailableView(
                        "No Payments",
                        systemImage: "dollarsign.circle",
                        description: Text("Tap + to record a payment.")
                    )
                } else {
                    ForEach(payments) { payment in
                        VStack(alignment: .leading, spacing: 6) {
                            
                            HStack {
                                Text(payment.customer?.name ?? "Unknown Customer")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text(
                                    payment.amount,
                                    format: .currency(code: "USD")
                                )
                                .fontWeight(.semibold)
                            }
                            
                            HStack {
                                Text(payment.month)
                                
                                Text("•")
                                
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
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deletePayments)
                }
            }
            .navigationTitle("Payments")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddPayment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPayment) {
                AddPaymentView()
            }
        }
    }
    
    private func deletePayments(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(payments[index])
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete payment: \(error)")
        }
    }
}

#Preview {
    PaymentsView()
        .modelContainer(
            for: [
                Customer.self,
                Payment.self
            ],
            inMemory: true
        )
}
