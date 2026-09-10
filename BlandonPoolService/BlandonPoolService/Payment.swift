//
//  Payment.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//

import Foundation
import SwiftData

@Model
class Payment {
    var amount: Double
    var paymentMethod: String
    var month: String
    var paymentDate: Date

    var customer: Customer?

    init(
        amount: Double,
        paymentMethod: String,
        month: String,
        paymentDate: Date,
        customer: Customer? = nil
    ) {
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.month = month
        self.paymentDate = paymentDate
        self.customer = customer
    }
}
