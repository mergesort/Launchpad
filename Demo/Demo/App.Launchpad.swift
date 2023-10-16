import Launchpad
import SwiftUI

// These are very basic tasks to demonstrate a simple app structure.
// You can imagine these tasks would actually be setting up your app at launch, as all apps need.
//
// You can initialize dependencies like crash reporting, telemetry, setup a database,
// run migrations, and so much more.
//
// Ordered tasks run first, because their order matters. For example if you need to run a migration
// before initializing your API, then those should be structured as ordered tasks.

// Below Print1LaunchTask, Print2LaunchTask, and Print3LaunchTask are ordered tasks
// and they will execute in the order they are added.

// IdentifiedLaunchTask is a regular StartupTask with no order specified, those will execute
// in parallel. This is useful when you need to do something on startup, but you can
// fire and forget because there are no dependencies.

@main
struct LaunchpadDemoApp: App {
    @StateObject private var launchController = LaunchController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .addLaunchTask(Print1LaunchTask())
                .addLaunchTask(IdentifiedLaunchTask(id: 1))
                .addLaunchTask(IdentifiedLaunchTask(id: 2))
                .addLaunchTask(IdentifiedLaunchTask(id: 3))
                .addLaunchTask(IdentifiedLaunchTask(id: 4))
                .addLaunchTask(IdentifiedLaunchTask(id: 5))
                .addLaunchTask(IdentifiedLaunchTask(id: 6))
                .addLaunchTask(IdentifiedLaunchTask(id: 7))
                .addLaunchTask(IdentifiedLaunchTask(id: 8))
                .addLaunchTask(IdentifiedLaunchTask(id: 9))
                .addLaunchTask(Print2LaunchTask())
                .addLaunchTask(Print3LaunchTask())
                .liftoff()
                .environmentObject(self.launchController)
        }
    }
}

private struct Print1LaunchTask: OrderedLaunchTaskModifier {
    @EnvironmentObject var launchController: LaunchController

    func task() async {
        print("Executing task 1")
    }
}

private struct Print2LaunchTask: OrderedLaunchTaskModifier {
    @EnvironmentObject var launchController: LaunchController

    func task() async {
        print("Executing task 2")
    }
}

private struct Print3LaunchTask: OrderedLaunchTaskModifier {
    @EnvironmentObject var launchController: LaunchController

    func task() async {
        print("Executing task 3")
    }
}

private struct IdentifiedLaunchTask: LaunchTaskModifier {
    @EnvironmentObject var launchController: LaunchController

    private let id: Int

    init(id: Int) {
        self.id = id
    }

    func task() async {
        let randomDuration = Double.random(in: 0...0.01)
        try? await Task.sleep(nanoseconds: UInt64(1_000_000_000 * randomDuration))
        print("Executing parallel task with ID \(self.id), in no particular order")
    }
}
