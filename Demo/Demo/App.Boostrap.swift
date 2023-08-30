import Startling
import SwiftUI

// These are very basic tasks to demonstrate a simple app structure.
// You can imagine these tasks would actually be setting up your app at launch, as all apps need.
//
// You can initialize dependencies like crash reporting, telemetry, setup a database,
// run migrations, and so much more.
//
// Ordered tasks run first, because their order matters. For example if you need to run a migration
// before initializing your API, then those should be structured as ordered tasks.

// Below Print1StartupTask, Print2StartupTask, and Print3StartupTask are ordered tasks
// and they will execute in the order they are added.

// IdentifiedStartupTask is a regular StartupTask with no order specified, those will execute
// in parallel. This is useful when you need to do something on startup, but you can
// fire and forget because there are no dependencies.

@main
struct BoostrapDemoApp: App {
    @StateObject private var startupTasksController = StartupTasksController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .addStartupTask(Print1StartupTask())
                .addStartupTask(IdentifiedStartupTask(id: 1))
                .addStartupTask(IdentifiedStartupTask(id: 2))
                .addStartupTask(IdentifiedStartupTask(id: 3))
                .addStartupTask(IdentifiedStartupTask(id: 4))
                .addStartupTask(IdentifiedStartupTask(id: 5))
                .addStartupTask(IdentifiedStartupTask(id: 6))
                .addStartupTask(IdentifiedStartupTask(id: 7))
                .addStartupTask(IdentifiedStartupTask(id: 8))
                .addStartupTask(IdentifiedStartupTask(id: 9))
                .addStartupTask(Print2StartupTask())
                .addStartupTask(Print3StartupTask())
                .runStartupTasks()
                .environmentObject(self.startupTasksController)
        }
    }
}

private struct Print1StartupTask: OrderedStartupTaskModifier {
    @EnvironmentObject var startupTasksController: StartupTasksController

    func task() async {
        print("Executing task 1")
    }
}

private struct Print2StartupTask: OrderedStartupTaskModifier {
    @EnvironmentObject var startupTasksController: StartupTasksController

    func task() async {
        print("Executing task 2")
    }
}

private struct Print3StartupTask: OrderedStartupTaskModifier {
//    @EnvironmentObject private var migrationsController: MigrationsController
    @EnvironmentObject var startupTasksController: StartupTasksController

    func task() async {
        print("Executing task 3")
    }
}

private struct IdentifiedStartupTask: StartupTaskModifier {
    @EnvironmentObject var startupTasksController: StartupTasksController

    private let id: Int

    init(id: Int) {
        self.id = id
    }

    func task() async {
        print("Executing parallel task with ID \(self.id), in no particular order")
    }
}
