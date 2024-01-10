//
//  ContentView.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  
  static private var showDone = true
  
  @Query(
    filter: #Predicate<Todo>{ showDone ? true : !$0.isDone },
    sort: [
//      .init(\Todo.isDone),
      .init(\.createAt, order: .reverse)
    ],
    animation: .bouncy)
  private var todos: [Todo]
  
  var body: some View {
    NavigationSplitView {
      List {
        ForEach(todos) { todo in
          NavigationLink {
            TodoDetail(todo: todo)
          } label: {
            TodoRow(todo: todo)
          }
        }
        .onDelete(perform: deleteItems)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select an item")
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = Todo(name: "New Task")
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(todos[index])
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Todo.self, inMemory: true)
}
