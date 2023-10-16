import SwiftUI

public protocol LaunchTaskModifier: ViewModifier {
    var launchController: LaunchController { get }

    @Sendable func task() async
}

public extension LaunchTaskModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask(self.task)
        })
    }
}
