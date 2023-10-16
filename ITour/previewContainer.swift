//
//  previewContainer.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftData
import SwiftUI
///USAGE
//MARK: - When previewing view that takes data as input
///#Preview {
///  ModelPreview { sampleData in
///    ContentView(data: sampleData)
///  }
///}

//MARK: - When previewing view that doesn't take any input
///#Preview {
///  ContentView()
///    .modelContainer(previewContainer)
///}


///Model Container to be used for preview when using SwiftData
///Add the data type for ModelContainer  and make one or more sample data that will be shown in preview
let previewContainer: ModelContainer = {
  do {
    let container = try ModelContainer(for: Destination.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    Task { @MainActor in
      let context = container.mainContext
      
      let sampleData = Destination(name: "Tokyo", details: "City thats busy day and night! Lots of cool place to visit and foods to eat no matter what the time is!!!", date: Date.distantPast, priority: 1)
      let sampleData2 = Destination(name: "Shibuya", details: "Fight between Gojo and Sukuna happened here. last I heard.....Gojo died", date: Date.now, priority: 1)
      let sampleData3 = Destination(name: "Konoha", details: "City of Ninjas but not very secrative... After Boruto was born the city just destoryed itself.", date: Date.distantPast, priority: 3)
      context.insert(sampleData)
      context.insert(sampleData2)
      context.insert(sampleData3)

    }
    return container
  } catch {
    fatalError("PreviewContainer failed to return ModelContainer\(error.localizedDescription)")
  }
}()



struct ModelPreview<Model: PersistentModel, Content: View>: View {
  var content: (Model) -> Content
  init(@ViewBuilder content: @escaping(Model) -> Content) {
    self.content = content
  }
  var body: some View {
    PreviewContent(content: content)
      .modelContainer(previewContainer)
  }
  struct PreviewContent: View {
    @Query private var models: [Model]
    var content: (Model) -> Content
    
    @State private var waitedToShowIssue = false
    var body: some View {
      if let model = models.first {
        content(model)
      } else {
        ContentUnavailableView("Could not load model for preview", systemImage: "xmark")
          .opacity(waitedToShowIssue ? 1 : 0)
          .task {
            Task {
              try await Task.sleep(for: .seconds(1))
              waitedToShowIssue = true
            }
          }
      }
    }
  }
}



