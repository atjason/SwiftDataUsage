//
//  TodoDetail.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import SwiftUI

struct TodoDetail: View {
  
  @Bindable var todo: Todo
  
  var body: some View {
    VStack {
      TextField("Task", text: $todo.name)
        .textFieldStyle(.roundedBorder)
        .padding(.vertical)
      Toggle(isOn: $todo.isDone, label: {
        Text("Done")
      })
      Spacer()
    }
    .padding()
  }
}

#Preview {
  TodoDetail(todo: Todo(name: "New"))
}
