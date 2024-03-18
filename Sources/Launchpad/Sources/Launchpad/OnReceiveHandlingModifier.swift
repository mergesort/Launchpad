import Combine
import SwiftUI

public protocol OnReceiveHandlingModifier: ViewModifier {
    associatedtype PublisherSuccess
    associatedtype PublishedValue: Combine.Publisher<PublisherSuccess, Never>

    var publisher: PublishedValue { get }

    func handleOnReceive(of value: PublisherSuccess)
}

public extension OnReceiveHandlingModifier {
    func body(content: Content) -> some View {
        content.onReceive(self.publisher, perform: { value in
            self.handleOnReceive(of: value)
        })
    }
}
