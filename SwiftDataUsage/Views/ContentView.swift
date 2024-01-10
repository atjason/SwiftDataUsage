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
    filter: #Predicate<Todo>{ !$0.isDone },
    sort: [
//      .init(\Todo.isDone),
      .init(\Todo.createAt, order: .reverse)
    ],
    animation: .bouncy)
  private var todosOpen: [Todo]
  
  @Query(
    filter: #Predicate<Todo>{ $0.isDone },
    sort: [
//      .init(\Todo.isDone),
      .init(\Todo.createAt, order: .reverse)
    ],
    animation: .bouncy)
  private var todosDone: [Todo]
  
  var body: some View {
    NavigationSplitView {
      List {
        Section() {
          ForEach(todosOpen) { todo in
            NavigationLink {
              TodoDetail(todo: todo)
            } label: {
              TodoRow(todo: todo)
            }
          }
          .onDelete(perform: deleteItems)
        }
        
        Section("Done") {
          ForEach(todosDone) { todo in
            NavigationLink {
              TodoDetail(todo: todo)
            } label: {
              TodoRow(todo: todo)
            }
          }
          .onDelete(perform: deleteItems)
        }
      }
      .navigationTitle("Todo")
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
        modelContext.delete(todosOpen[index])
      }
    }
  }
}

extension Bool: Comparable {
  public static func <(lhs: Self, rhs: Self) -> Bool {
    // the only true inequality is false < true
    !lhs && rhs
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Todo.self)
}
