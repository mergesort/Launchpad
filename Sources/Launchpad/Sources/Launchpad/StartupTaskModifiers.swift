import SwiftUI

public protocol LaunchTaskModifier: ViewModifier {
    var launchController: LaunchController { get }

    func onLaunch() async
}

public extension LaunchTaskModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask({
                await self.onLaunch()
            })
        })
    }
}
