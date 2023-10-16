//
//  ITourApp.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftUI
import SwiftData
@main
struct ITourApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Destination.self)
  }
}
