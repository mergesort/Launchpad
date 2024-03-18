import SwiftUI

public protocol OnChangeHandlingModifier: ViewModifier {
    associatedtype EquatableValue: Equatable

    var value: EquatableValue { get }

    func handleOnChange(of value: EquatableValue)
}

public extension OnChangeHandlingModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        content.onChange(of: self.value, perform: { value in
            self.handleOnChange(of: value)
        })
    }
}
