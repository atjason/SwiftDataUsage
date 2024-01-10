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
  
  @Query(
    //    filter: #Predicate<Todo>{ !$0.isDone },
    sort: [
      .init(\Todo.isDone),
      .init(\Todo.createAt, order: .reverse)
    ],
    animation: .bouncy)
  private var todos: [Todo]
  
  @State private var showDone = true
  
  var body: some View {
    NavigationSplitView {
      List {
        ForEach(todos) { todo in
          if (showDone || !todo.isDone) {
            NavigationLink {
              TodoDetail(todo: todo)
            } label: {
              TodoRow(todo: todo)
            }
          }
        }
        .onDelete(perform: deleteItems)
      }
      .navigationTitle("Todo")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: { showDone.toggle() }) {
            Label("Show Done Tasks", systemImage: showDone ? "checkmark.circle.fill" : "circle")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
        ToolbarItem {
          Button(action: { modelContext.undoManager?.undo() }) {
            Label("Undo", systemImage: "arrow.uturn.backward")
          }
        }
        ToolbarItem {
          Button(action: { modelContext.undoManager?.redo() }) {
            Label("Redo", systemImage: "arrow.uturn.forward")
          }
        }
      }
      
      Spacer()
      
      NavigationLink {
        ContentViewManually()
      } label: {
        Text("Manually")
      }
      
    } detail: {
      Text("Add a task first.")
    }
  }
  
  private func addItem() {
    let newItem = Todo(name: "New Task")
    modelContext.insert(newItem)
  }
  
  private func deleteItems(offsets: IndexSet) {
    for index in offsets {
      modelContext.delete(todos[index])
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Todo.self, isUndoEnabled: true)
}
