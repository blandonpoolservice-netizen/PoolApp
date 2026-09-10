import SwiftUI
import SwiftData

@main
struct BlandonPoolServiceApp: App {

    var body: some Scene {

        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Customer.self,
            Payment.self,
            BackupIdentity.self
        ])
    }
}
