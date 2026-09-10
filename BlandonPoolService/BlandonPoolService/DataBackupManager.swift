import Foundation
import SwiftData

@MainActor
final class DataBackupManager {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Export

    func exportBackup() throws -> Data {

        let customers = try modelContext.fetch(
            FetchDescriptor<Customer>()
        )

        // Get all existing backup identities.
        var identities = try modelContext.fetch(
            FetchDescriptor<BackupIdentity>()
        )

        var customerBackups: [CustomerBackup] = []

        for customer in customers {

            // Find an existing stable ID for this customer.
            var customerIdentity = identities.first {
                $0.customer === customer &&
                $0.entityType == BackupIdentity.EntityType.customer
            }

            // If this customer does not have an ID yet, create one.
            if customerIdentity == nil {

                let newIdentity = BackupIdentity(
                    entityType: BackupIdentity.EntityType.customer,
                    backupID: UUID(),
                    customer: customer
                )

                modelContext.insert(newIdentity)
                identities.append(newIdentity)

                customerIdentity = newIdentity
            }

            guard let customerID = customerIdentity?.backupID else {
                continue
            }

            var paymentBackups: [PaymentBackup] = []

            for payment in customer.payments {

                // Find an existing stable ID for this payment.
                var paymentIdentity = identities.first {
                    $0.payment === payment &&
                    $0.entityType == BackupIdentity.EntityType.payment
                }

                // If this payment does not have an ID yet, create one.
                if paymentIdentity == nil {

                    let newIdentity = BackupIdentity(
                        entityType: BackupIdentity.EntityType.payment,
                        backupID: UUID(),
                        payment: payment
                    )

                    modelContext.insert(newIdentity)
                    identities.append(newIdentity)

                    paymentIdentity = newIdentity
                }

                guard let paymentID = paymentIdentity?.backupID else {
                    continue
                }

                paymentBackups.append(
                    PaymentBackup(
                        id: paymentID,
                        amount: payment.amount,
                        paymentMethod: payment.paymentMethod,
                        month: payment.month,
                        paymentDate: payment.paymentDate
                    )
                )
            }

            customerBackups.append(
                CustomerBackup(
                    id: customerID,
                    name: customer.name,
                    address: customer.address,
                    phone: customer.phone,
                    email: customer.email,
                    serviceType: customer.serviceType,
                    serviceDay: customer.serviceDay,
                    monthlyPrice: customer.monthlyPrice,
                    outstandingBalance: customer.outstandingBalance,
                    paymentHandle: customer.paymentHandle,
                    notes: customer.notes,
                    isActive: customer.isActive,
                    payments: paymentBackups
                )
            )
        }

        // Save the newly-created BackupIdentity records.
        try modelContext.save()

        let backup = BusinessBackup(
            version: 1,
            exportDate: Date(),
            customers: customerBackups
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [
            .prettyPrinted,
            .sortedKeys
        ]

        return try encoder.encode(backup)
    }


    // MARK: - Import

    func importBackup(
        from data: Data
    ) throws -> (
        customers: Int,
        payments: Int,
        skippedCustomers: Int,
        skippedPayments: Int
    ) {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let backup = try decoder.decode(
            BusinessBackup.self,
            from: data
        )

        // Load all existing backup identities once.
        var identities = try modelContext.fetch(
            FetchDescriptor<BackupIdentity>()
        )

        var importedCustomers = 0
        var importedPayments = 0
        var skippedCustomers = 0
        var skippedPayments = 0

        for customerData in backup.customers {

            // Check whether this exact customer backup ID already exists.
            let existingCustomerIdentity = identities.first {
                $0.backupID == customerData.id &&
                $0.entityType == BackupIdentity.EntityType.customer
            }

            if existingCustomerIdentity != nil {
                skippedCustomers += 1
                continue
            }

            // Create the customer.
            let customer = Customer(
                name: customerData.name,
                address: customerData.address,
                phone: customerData.phone,
                email: customerData.email,
                serviceType: customerData.serviceType,
                serviceDay: customerData.serviceDay,
                monthlyPrice: customerData.monthlyPrice,
                outstandingBalance: customerData.outstandingBalance,
                paymentHandle: customerData.paymentHandle,
                notes: customerData.notes,
                isActive: customerData.isActive
            )

            modelContext.insert(customer)

            // Create the stable identity for this customer.
            let customerIdentity = BackupIdentity(
                entityType: BackupIdentity.EntityType.customer,
                backupID: customerData.id,
                customer: customer
            )

            modelContext.insert(customerIdentity)
            identities.append(customerIdentity)

            importedCustomers += 1

            // Import all payments belonging to this customer.
            for paymentData in customerData.payments {

                // Check whether this exact payment backup ID already exists.
                let existingPaymentIdentity = identities.first {
                    $0.backupID == paymentData.id &&
                    $0.entityType == BackupIdentity.EntityType.payment
                }

                if existingPaymentIdentity != nil {
                    skippedPayments += 1
                    continue
                }

                let payment = Payment(
                    amount: paymentData.amount,
                    paymentMethod: paymentData.paymentMethod,
                    month: paymentData.month,
                    paymentDate: paymentData.paymentDate,
                    customer: customer
                )

                modelContext.insert(payment)

                // Create the stable identity for this payment.
                let paymentIdentity = BackupIdentity(
                    entityType: BackupIdentity.EntityType.payment,
                    backupID: paymentData.id,
                    payment: payment
                )

                modelContext.insert(paymentIdentity)
                identities.append(paymentIdentity)

                importedPayments += 1
            }
        }

        try modelContext.save()

        return (
            customers: importedCustomers,
            payments: importedPayments,
            skippedCustomers: skippedCustomers,
            skippedPayments: skippedPayments
        )
    }
}
