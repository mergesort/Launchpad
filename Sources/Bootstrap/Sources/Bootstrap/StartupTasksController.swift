import SwiftUI

public actor StartupTasksController: ObservableObject {
    var orderedTasks: [StartupTask] = []
    var parallelTasks: [StartupTask] = []

    public init() { }

    public func addOrderedTask(_ action: @escaping () async -> Void) async {
        self.orderedTasks.append(
            StartupTask(
                priority: self.parallelTasks.count + self.orderedTasks.count,
                action: action
            )
        )
    }

    public func addParallelTask(_ action: @escaping () async -> Void) async {
        self.parallelTasks.append(
            StartupTask(
                priority: self.parallelTasks.count + self.orderedTasks.count,
                action: action
            )
        )
    }

    func runStartupTasks() async {
        for task in self.orderedTasks.sorted(by: { $0.priority < $1.priority }) {
            await task.action()
        }

        self.orderedTasks.removeAll()

        for task in self.parallelTasks {
            Task {
                await task.action()
                self.parallelTasks.removeAll(where: { $0.id == task.id })
            }
        }
    }
}

internal extension StartupTasksController {
    struct StartupTask: Identifiable {
        let id = UUID()
        let priority: Int
        let action: () async -> Void
    }
}
