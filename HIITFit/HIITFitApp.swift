

import SwiftUI

@main
struct HIITFitApp: App {
    @StateObject private var historyStore = HistoryStore()
  var body: some Scene {
    WindowGroup {
      ContentView()
            .environmentObject(historyStore)
    }
  }
}
