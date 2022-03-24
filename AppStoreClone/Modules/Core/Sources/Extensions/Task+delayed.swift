//
//  Task+delayed.swift
//  Core
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

extension Task where Failure == Error {
    static func delayed(
        byTimeInterval delayInterval: TimeInterval,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            let delay = UInt64(delayInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}
