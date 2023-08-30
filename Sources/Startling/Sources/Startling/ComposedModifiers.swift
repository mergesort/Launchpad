import SwiftUI

// MARK: StartupTaskModifier Combinations

public extension StartupTaskModifier where Self: OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addParallelTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
    }
}

public extension StartupTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addParallelTask {
                await self.task()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

public extension StartupTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addParallelTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

// MARK: OrderedStartupTaskModifier Combinations

public extension OrderedStartupTaskModifier where Self: OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addOrderedTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
    }
}

public extension OrderedStartupTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addOrderedTask {
                await self.task()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

public extension OrderedStartupTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.startupTasksController.addOrderedTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

// MARK: OnChange/OnReceive Combinations

public extension OnChangeHandlingModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}
