import Foundation
import SwiftData

@Model
class Customer {

    var name: String
    var address: String
    var phone: String
    var email: String
    var serviceType: String
    var serviceDay: String?
    var monthlyPrice: Double
    var outstandingBalance: Double?
    var paymentHandle: String?
    var notes: String?
    var isActive: Bool?

    @Relationship(deleteRule: .cascade, inverse: \Payment.customer)
    var payments: [Payment] = []

    init(
        name: String,
        address: String = "",
        phone: String = "",
        email: String = "",
        serviceType: String = "Full Service",
        serviceDay: String? = nil,
        monthlyPrice: Double = 0,
        outstandingBalance: Double? = nil,
        paymentHandle: String? = nil,
        notes: String? = nil,
        isActive: Bool? = nil
    ) {
        self.name = name
        self.address = address
        self.phone = phone
        self.email = email
        self.serviceType = serviceType
        self.serviceDay = serviceDay
        self.monthlyPrice = monthlyPrice
        self.outstandingBalance = outstandingBalance
        self.paymentHandle = paymentHandle
        self.notes = notes
        self.isActive = isActive
    }
}
