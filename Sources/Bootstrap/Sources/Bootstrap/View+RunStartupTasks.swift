import SwiftUI

public extension View {
    func runStartupTasks() -> some View {
        self.modifier(RunStartupTasksModifier())
    }

    // MARK: StartupTaskModifier Combinations

    func addStartupTask(_ task: some StartupTaskModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some StartupTaskModifier & OnChangeHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some StartupTaskModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some StartupTaskModifier & OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    // MARK: OrderedStartupTaskModifier Combinations

    func addStartupTask(_ task: some OrderedStartupTaskModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some OrderedStartupTaskModifier & OnChangeHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some OrderedStartupTaskModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    func addStartupTask(_ task: some OrderedStartupTaskModifier & OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(task)
    }

    // MARK: OnChange/OnReceive Combinations

    func addStartupTask(_ handler: some OnChangeHandlingModifier) -> some View {
        self.modifier(handler)
    }

    func addStartupTask(_ handler: some OnReceiveHandlingModifier) -> some View {
        self.modifier(handler)
    }

    func addStartupTask(_ handler: some OnChangeHandlingModifier & OnReceiveHandlingModifier) -> some View {
        self.modifier(handler)
    }
}

// MARK: RunStartupTasksModifier

private struct RunStartupTasksModifier: ViewModifier {
    @EnvironmentObject private var startupTasksModifier: StartupTasksController

    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksModifier.runStartupTasks()
        })
    }
}
