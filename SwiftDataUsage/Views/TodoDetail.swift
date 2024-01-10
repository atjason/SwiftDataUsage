//
//  TodoDetail.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import SwiftUI

struct TodoDetail: View {
  
//  @Bindable var todo: Todo
  @State var todo: Todo
  
  var body: some View {
    VStack {
      TextField("Task", text: $todo.name)
      Toggle(isOn: .constant(true), label: {
        Text("Label")
      })
    }
    .padding()
  }
}

#Preview {
  TodoDetail(todo: Todo(name: "New"))
}
