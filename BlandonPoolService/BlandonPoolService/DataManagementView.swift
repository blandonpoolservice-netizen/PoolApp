//
//  DataManagementView.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/5/26.
//


import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct DataManagementView: View {

    @Environment(\.modelContext) private var modelContext

    @State private var showingExporter = false
    @State private var exportData: Data?
    @State private var statusMessage = ""
    @State private var showingImporter = false

    var body: some View {
        Form {

            Section {
                Text("Back up your customers and payment history so you can move your business data between devices.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Section("Export") {

                Button {
                    createBackup()
                } label: {
                    Label("Export Business Data", systemImage: "square.and.arrow.up")
                }
                .disabled(exportData != nil)
            }

            Section("Import") {

                Button {
                    showingImporter = true
                } label: {
                    Label("Import Business Data", systemImage: "square.and.arrow.down")
                }
            }

            if !statusMessage.isEmpty {
                Section("Status") {
                    Text(statusMessage)
                }
            }
        }
        .navigationTitle("Data Management")
        .fileExporter(
            isPresented: $showingExporter,
            document: BackupDocument(data: exportData ?? Data()),
            contentType: .json,
            defaultFilename: "BlandonPoolService-Backup.json"
        ) { result in
            switch result {
            case .success:
                statusMessage = "Backup exported successfully."

            case .failure(let error):
                statusMessage = "Export failed: \(error.localizedDescription)"
            }
        }
        .fileImporter(
            isPresented: $showingImporter,
            allowedContentTypes: [.json],
            allowsMultipleSelection: false
        ) { result in
            importBackup(result)
        }
    }

    private func createBackup() {

        do {
            let manager = DataBackupManager(
                modelContext: modelContext
            )

            let data = try manager.exportBackup()

            exportData = data

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let backup = try decoder.decode(
                BusinessBackup.self,
                from: data
            )

            let paymentCount = backup.customers.reduce(0) {
                $0 + $1.payments.count
            }

            statusMessage =
                "Ready to export \(backup.customers.count) customers and \(paymentCount) payments."

            showingExporter = true

        } catch {
            statusMessage =
                "Export failed: \(error.localizedDescription)"
        }
    }

    private func importBackup(
        _ result: Result<[URL], Error>
    ) {

        do {
            let urls = try result.get()

            guard let url = urls.first else {
                return
            }

            let accessGranted = url.startAccessingSecurityScopedResource()

            defer {
                if accessGranted {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            let data = try Data(contentsOf: url)

            let manager = DataBackupManager(
                modelContext: modelContext
            )

            let result = try manager.importBackup(
                from: data
            )

            statusMessage =
                """
                Import complete.

                Customers imported: \(result.customers)
                Payments imported: \(result.payments)
                Customers skipped: \(result.skippedCustomers)
                Payments skipped: \(result.skippedPayments)
                """
        } catch {
            statusMessage =
                "Import failed: \(error.localizedDescription)"
        }
    }
}


// MARK: - Backup Document

struct BackupDocument: FileDocument {

    static var readableContentTypes: [UTType] {
        [.json]
    }

    static var writableContentTypes: [UTType] {
        [.json]
    }

    var data: Data

    init(data: Data = Data()) {
        self.data = data
    }

    init(configuration: ReadConfiguration) throws {
        self.data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(
        configuration: WriteConfiguration
    ) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}