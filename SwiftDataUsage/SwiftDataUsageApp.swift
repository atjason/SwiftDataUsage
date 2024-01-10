//
//  SwiftDataUsageApp.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataUsageApp: App {
  
  let sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Todo.self,
    ])
    let modelConfiguration = ModelConfiguration(
      schema: schema,
  //    cloudKitDatabase: .private("iCloud.net.toolinbox.SwiftDataUsage"),
      isStoredInMemoryOnly: false
    )
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
//    .modelContainer(for: Todo.self)
  }
}
