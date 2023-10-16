import SwiftUI

// MARK: LaunchTaskModifier Combinations

public extension LaunchTaskModifier where Self: OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
    }
}

public extension LaunchTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
                await self.task()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

public extension LaunchTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
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

// MARK: OrderedLaunchTaskModifier Combinations
public extension OrderedLaunchTaskModifier where Self: OnChangeHandlingModifier {

    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.task()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
    }
}

public extension OrderedLaunchTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.task()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.onReceiveTask(value: value)
        })
    }
}

public extension OrderedLaunchTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
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
