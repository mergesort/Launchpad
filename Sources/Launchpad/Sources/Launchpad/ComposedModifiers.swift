import SwiftUI

// MARK: LaunchTaskModifier Combinations

public extension LaunchTaskModifier where Self: OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
                await self.onLaunch()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
    }
}

public extension LaunchTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
                await self.onLaunch()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}

public extension LaunchTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addParallelTask {
                await self.onLaunch()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}

// MARK: OrderedLaunchTaskModifier Combinations
public extension OrderedLaunchTaskModifier where Self: OnChangeHandlingModifier {

    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.onLaunch()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
    }
}

public extension OrderedLaunchTaskModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.onLaunch()
            }
        })
        .onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}

public extension OrderedLaunchTaskModifier where Self: OnReceiveHandlingModifier & OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.task({
            await self.launchController.addOrderedTask {
                await self.onLaunch()
            }
        })
        .onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}

// MARK: OnChange/OnReceive Combinations

public extension OnChangeHandlingModifier where Self: OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
        .onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}
