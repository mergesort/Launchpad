import SwiftUI

public extension View {
    func liftoff() -> some View {
        self.modifier(RunLaunchTasksModifier())
    }

    // MARK: StartupTaskModifier Combinations

    func addLaunchTask(_ task: some LaunchTaskModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some LaunchTaskModifier & OnChangeHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some LaunchTaskModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some LaunchTaskModifier & OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    // MARK: OrderedLaunchTaskModifier Combinations

    func addLaunchTask(_ task: some OrderedLaunchTaskModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some OrderedLaunchTaskModifier & OnChangeHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some OrderedLaunchTaskModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addLaunchTask(_ task: some OrderedLaunchTaskModifier & OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    // MARK: OnChange/OnReceive Combinations

    func addLaunchTask(_ handler: some OnChangeHandlingModifier) -> some View {
        self.modifier(handler)
    }

    func addLaunchTask(_ handler: some OnReceiveHandlingModifier) -> some View {
        self.modifier(handler)
    }

    func addLaunchTask(_ handler: some OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(handler)
    }
}

// MARK: RunStartupTasksModifier

private struct RunLaunchTasksModifier: ViewModifier {
    @EnvironmentObject private var launchController: LaunchController

    func body(content: Content) -> some View {
        content.task({
            await self.launchController.launch()
        })
    }
}
