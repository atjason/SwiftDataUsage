//
//  ContentViewManually.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/10.
//

import SwiftUI
import SwiftData

struct ContentViewManually: View {
  @Environment(\.modelContext) private var modelContext
  
  @State private var todos: [Todo] = []
    
  var body: some View {
    VStack {
      Button(action: {
        let predicate = #Predicate<Todo> { todo in
          // todo.isDone
          true
        }

        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.sortBy = [SortDescriptor(\.createAt)]

        todos.removeAll()
        try! modelContext.enumerate(
            descriptor,
            batchSize: 500,
            allowEscapingMutations: true
        ) { todo in
          todos.append(todo)
        }
        
      }, label: {
        Text("Fetch")
      })
      
      Button(action: {
        let predicate = #Predicate<Todo> { todo in
          // todo.isDone
          true
        }

        let descriptor = FetchDescriptor(predicate: predicate)
        let todos = try! modelContext.fetch(descriptor)
        todos.first?.isDone.toggle()
        
      }, label: {
        Text("Modify")
      })
      
      Button(action: {
        let todo = Todo(name: "New Task")
        modelContext.insert(todo)
        todos.insert(todo, at: 0)
      }, label: {
        Text("Add")
      })
      
      Button(action: {
        if let todo = todos.first {
          modelContext.delete(todo)
          todos.remove(at: 0)
        }
      }, label: {
        Text("Delete")
      })
    }
    .buttonStyle(.bordered)
    
    NavigationSplitView {
      List {
        ForEach(todos) { todo in
          NavigationLink {
            TodoDetail(todo: todo)
          } label: {
            TodoRow(todo: todo)
          }
        }
      }
    } detail: {
      Text("Add a task first.")
    }
  }
}

#Preview {
  ContentViewManually()
    .modelContainer(for: Todo.self)
}
