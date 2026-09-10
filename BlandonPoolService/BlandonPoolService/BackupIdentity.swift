import Foundation
import SwiftData

@Model
final class BackupIdentity {

    enum EntityType: String, Codable {
        case customer
        case payment
    }

    var backupID: UUID
    var entityType: EntityType

    var customer: Customer?
    var payment: Payment?

    init(
        entityType: EntityType,
        backupID: UUID = UUID(),
        customer: Customer? = nil,
        payment: Payment? = nil
    ) {
        self.entityType = entityType
        self.backupID = backupID
        self.customer = customer
        self.payment = payment
    }
}//
//  BackupIdentity.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//

