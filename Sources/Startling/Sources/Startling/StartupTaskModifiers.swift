import SwiftUI

public protocol StartupTaskModifier: ViewModifier {
    var startupTasksController: StartupTasksController { get }

    @Sendable func task() async
}

public extension StartupTaskModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addParallelTask(self.task)
        })
    }
}
