//
//  TodoRow.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/10.
//

import SwiftUI

struct TodoRow: View {
  @Bindable var todo: Todo
  
  var body: some View {
    HStack {
      Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
      Text(todo.name)
      Spacer()
    }
  }
}

#Preview {
  let todo = Todo(name: "New Task")
  todo.isDone = true
  return TodoRow(todo: todo)
}
