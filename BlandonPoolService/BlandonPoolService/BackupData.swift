import Foundation

struct CustomerBackup: Codable {
    let id: UUID
    let name: String
    let address: String
    let phone: String
    let email: String
    let serviceType: String
    let serviceDay: String?
    let monthlyPrice: Double
    let outstandingBalance: Double?
    let paymentHandle: String?
    let notes: String?
    let isActive: Bool?
    let payments: [PaymentBackup]
}

struct PaymentBackup: Codable {
    let id: UUID
    let amount: Double
    let paymentMethod: String
    let month: String
    let paymentDate: Date
}

struct BusinessBackup: Codable {
    let version: Int
    let exportDate: Date
    let customers: [CustomerBackup]
    //
    //  BackupData.swift
    //  BlandonPoolService
    //
    //  Created by Omar Blandon on 9/5/26.
    //
}
