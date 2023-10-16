import SwiftUI

public protocol OnChangeHandlingModifier: ViewModifier {
    associatedtype EquatableValue: Equatable

    var value: EquatableValue { get }

    @Sendable func onChangeTask(value: EquatableValue)
}

public extension OnChangeHandlingModifier {
    func body(content: Content) -> some View {
        content.onChange(of: self.value, perform: { value in
            self.onChangeTask(value: value)
        })
    }
}
