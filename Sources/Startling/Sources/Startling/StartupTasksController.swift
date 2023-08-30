import SwiftUI

public actor StartupTasksController: ObservableObject {
    var orderedTasks: [StartupTask] = []
    var parallelTasks: [StartupTask] = []

    public init() { }

    public func addOrderedTask(_ action: @escaping () async -> Void) async {
        self.orderedTasks.append(
            StartupTask(action: action)
        )
    }

    public func addParallelTask(_ action: @escaping () async -> Void) async {
        self.parallelTasks.append(
            StartupTask(action: action)
        )
    }

    func runStartupTasks() async {
        for task in self.parallelTasks {
            Task {
                await task.action()
                self.parallelTasks.removeAll(where: { $0.id == task.id })
            }
        }

        for task in self.orderedTasks {
            await task.action()
        }

        self.orderedTasks.removeAll()
    }
}

internal extension StartupTasksController {
    struct StartupTask: Identifiable {
        let id = UUID()
        let action: () async -> Void
    }
}
