//
//  ContentView.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  //MARK: Variable defination
  @State private var path = [Destination]()
  @Environment(\.modelContext) var moc
  @State private var sortOrder = SortDescriptor(\Destination.name)
  
  //MARK: View
  var body: some View {
    NavigationStack(path: $path) {
      DestinationListingView(sort: sortOrder)
        .navigationTitle("iTour")
        .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
        .toolbar {
          Button("Add",systemImage: "plus", action: addDestination)
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
              Text("Name").tag(SortDescriptor(\Destination.name))
              Text("Priority").tag(SortDescriptor(\Destination.priority, order: .reverse))
              Text("Date").tag(SortDescriptor(\Destination.date, order: .reverse))
            }
          }
        }
    }
  }
  //MARK: Function
  private func addDestination() {
    let destination = Destination()
    moc.insert(destination)
    path = [destination]
  }
}

#Preview {
  ContentView()
}

