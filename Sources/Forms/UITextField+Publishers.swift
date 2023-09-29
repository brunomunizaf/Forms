import Combine
import UIKit

extension UITextField {
  /// A publisher emitting text change events from this text field.
  var textPublisher: AnyPublisher<String?, Never> {
    Publishers.TextFieldPublisher(
      textField: self
    ).eraseToAnyPublisher()
  }
}

extension Publishers {
  /// A publisher that emits a value when the text in the specified text field changes.
  struct TextFieldPublisher: Publisher {
    typealias Output = String?
    typealias Failure = Never

    private let textField: UITextField

    /// Creates a text field publisher for the given text field.
    /// - Parameter textField: The text field to observe.
    init(textField: UITextField) {
      self.textField = textField
    }

    /// Attaches the subscriber to the publisher.
    /// - Parameter subscriber: The subscriber to attach to this publisher.
    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = TextFieldSubscription(subscriber: subscriber, textField: textField)
      subscriber.receive(subscription: subscription)
    }
  }

  /// The subscription class for `TextFieldPublisher`.
  private final class TextFieldSubscription<S: Subscriber, Control: UITextField>: Subscription where S.Input == String? {
    private var subscriber: S?
    private weak var textField: Control?

    /// Initializes a subscription for the given subscriber and text field.
    /// - Parameters:
    ///   - subscriber: The subscriber to receive events.
    ///   - textField: The text field to observe.
    init(subscriber: S, textField: Control) {
      self.subscriber = subscriber
      self.textField = textField
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    /// Requests the specified number of values upon subscription.
    /// - Parameter demand: The number of values to request.
    func request(_ demand: Subscribers.Demand) {}

    /// Cancels the subscription, ending future value deliveries.
    func cancel() {
      subscriber = nil
    }

    /// Invoked when the text in the observed text field changes.
    @objc private func textDidChange() {
      _ = subscriber?.receive(textField?.text)
    }
  }
}
