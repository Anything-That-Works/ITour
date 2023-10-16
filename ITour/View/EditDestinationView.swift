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
  @State private var newSightname = ""
  //MARK: View
  var body: some View {
    Form {
      TextField("Name", text: $desination.name)
      TextField("Details", text: $desination.details, axis: .vertical)
      DatePicker("Date", selection: $desination.date)
      Section("Priority") {
        Picker("Priority", selection: $desination.priority) {
          Text("Meh").tag(1)
          Text("Maybe").tag(2)
          Text("Must").tag(3)
        }.pickerStyle(.segmented)
      }
      Section("Sights") {
        ForEach(desination.sights) { sight in
          Text(sight.name)
        }.onDelete(perform: deleteSight)
        HStack {
          TextField("Add a new Sight name", text: $newSightname)
          Button("Add", action: addSight)
        }
      }
    }
    .navigationTitle("Edit Destination")
    .navigationBarTitleDisplayMode(.inline)
  }
  func deleteSight(_ indexSet: IndexSet) {
    for index in indexSet {
//      let sights = desination.sights[index]
      desination.sights.remove(at: index)
//      desination.sights.remove(at: index)
    }
  }
  func addSight() {
    guard newSightname.isEmpty ==  false else { return }
    withAnimation {
      desination.sights.append(Sight(name: newSightname))
      newSightname = ""
    }
  }
}

#Preview("EditDestinationView") {
  ModelPreview { destination in
    EditDestinationView(desination: destination)
  }
}
