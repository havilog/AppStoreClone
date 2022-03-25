//
//  Subject+emittingValues.swift
//  Core
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import Combine

public extension PassthroughSubject where Failure == Error {
    static func emittingValues<T: AsyncSequence>(
        from sequence: T
    ) -> Self where T.Element == Output {
        let subject = Self()

        Task {
            do {
                for try await value in sequence {
                    subject.send(value)
                }

                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }

        return subject
    }
}
