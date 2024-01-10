//
//  CloudKitHelper.swift
//  SwiftDataUsage
//
//  Created by Jason Zheng on 2024/1/10.
//

import Foundation
import CloudKit

struct CloudKitHelper {
  
  static func checkCloudKitStatus() async -> CKAccountStatus {
    do {
      return try await CKContainer.default().accountStatus()
    } catch {
      return .temporarilyUnavailable
    }
  }
}
