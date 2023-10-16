//
//  EditDestinationView.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
  //MARK: Variable Defination
  @Bindable var desination: Destination
  
  //MARK: View
  var body: some View {
    Form {
      TextField("Name", text: $desination.name)
      TextField("Details", text: $desination.details, axis: .vertical)
      DatePicker("Date", selection: $desination.date)
      Section("Priority") {
        Picker("Priority", selection: $desination.priority) {
          Text("meh").tag(1)
          Text("Maybe").tag(2)
          Text("Must").tag(3)
        }.pickerStyle(.segmented)
      }
    }
    .navigationTitle("Edit Destination")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Destination.self, configurations: config)
    
    let example = Destination(name: "Example", details: "A very very very long Text to simulate data.")
    return EditDestinationView(desination: example)
      .modelContainer(container)
  } catch {
    fatalError("Failed to create model container")
  }
}
