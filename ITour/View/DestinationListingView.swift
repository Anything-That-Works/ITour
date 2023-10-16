//
//  DestinationListingView.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
  //MARK: Variable Defination
  @Query var destinations: [Destination]
  @Environment(\.modelContext) var moc
  init(sort: SortDescriptor<Destination>) {
    _destinations = Query(sort: [sort], animation: .bouncy)
  }
  
  //MARK: View
  var body: some View {
    List {
      ForEach(destinations) {destination in
        NavigationLink(value: destination) {
          VStack(alignment: .leading) {
            Text(destination.name)
              .font(.headline)
            Text(destination.date.formatted(date: .long, time: .shortened))
          }
        }
      }.onDelete(perform: deleteDestinations)
    }
  }
  
  //MARK: Function Defination
  private func deleteDestinations(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destinations[index]
      moc.delete(destination)
    }
  }
}

#Preview {
  DestinationListingView(sort: SortDescriptor(\Destination.name))
}
