import SwiftUI

public actor LaunchController: ObservableObject {
    var orderedTasks: [LaunchTask] = []
    var parallelTasks: [LaunchTask] = []

    var hasRunLaunchTasks = false

    public init() {}

    public func addOrderedTask(_ action: @Sendable @escaping () async -> Void) async {
        self.orderedTasks.append(
            LaunchTask(action: action)
        )
    }

    public func addParallelTask(_ action: @Sendable @escaping () async -> Void) async {
        self.parallelTasks.append(
            LaunchTask(action: action)
        )
    }

    func launch() async {
        guard !self.hasRunLaunchTasks else { return }

        for task in self.orderedTasks {
            await task.action()
        }

        for task in self.parallelTasks {
            Task {
                await task.action()
                self.parallelTasks.removeAll(where: { $0.id == task.id })
            }
        }

        self.orderedTasks.removeAll()
        self.hasRunLaunchTasks = true
    }
}

internal extension LaunchController {
    struct LaunchTask: Identifiable {
        let id = UUID()
        let action: @Sendable () async -> Void
    }
}
