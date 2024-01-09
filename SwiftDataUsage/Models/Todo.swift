//
//  Item.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import Foundation
import SwiftData

@Model
final class Todo: Equatable {
  
  @Attribute(.unique)
  let id = UUID()
  var name: String = ""
  var isDone: Bool = false
  let createAt: Date = Date.now
  
  init(name: String) {
    self.name = name
  }
}