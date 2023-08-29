import SwiftUI

public protocol OrderedStartupTaskModifier: ViewModifier {
    var startupTasksController: StartupTasksController { get }

    func task() async
}

public extension OrderedStartupTaskModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addOrderedTask {
                await self.task()
            }
        })
    }
}
