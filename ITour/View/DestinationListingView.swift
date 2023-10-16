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
  
  init(sort: SortDescriptor<Destination>, searchString: String) {
//    MARK: Default init
//    _destinations = Query(sort: [sort])
//    MARK: with HardCoded filter Predicate
//    _destinations = Query(filter: #Predicate{$0.priority > 1},sort: [sort])
//    MARK: with Search filter
    
    _destinations = Query(filter: #Predicate{
      if searchString.isEmpty {
        return true
      } else {
        return $0.name.localizedStandardContains(searchString)
      }
    },sort: [sort])
  }
}

#Preview {
  DestinationListingView(sort: SortDescriptor(\Destination.date), searchString: "")
    .modelContainer(previewContainer)
}
