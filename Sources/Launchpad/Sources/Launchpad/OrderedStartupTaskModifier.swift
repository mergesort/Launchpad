import SwiftUI

public protocol OrderedLaunchTaskModifier: ViewModifier {
    var launchController: LaunchController { get }

    func task() async
}

public extension OrderedLaunchTaskModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.task()
            }
        })
    }
}
