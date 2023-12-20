

import SwiftUI

@main
struct HIITFitApp: App {
    @StateObject private var historyStore = HistoryStore()
  var body: some Scene {
    WindowGroup {
      ContentView()
            .environmentObject(historyStore)
            .alert(isPresented: $historyStore.loadingError) {
              Alert(
                title: Text("History"),
                message: Text(
                  """
                  Unfortunately we can't load your past history.
                  Email support:
                    support@xyz.com
                  """))
            }
    }
  }
}
