//
//  Item.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/9.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
