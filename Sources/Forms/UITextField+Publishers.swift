import Combine
import UIKit

extension UITextField {
  var textPublisher: AnyPublisher<String?, Never> {
    Publishers.TextFieldPublisher(
      textField: self
    ).eraseToAnyPublisher()
  }
}

extension Publishers {
  struct TextFieldPublisher: Publisher {
    typealias Output = String?
    typealias Failure = Never

    private let textField: UITextField

    init(textField: UITextField) {
      self.textField = textField
    }

    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = TextFieldSubscription(subscriber: subscriber, textField: textField)
      subscriber.receive(subscription: subscription)
    }
  }

  private final class TextFieldSubscription<S: Subscriber, Control: UITextField>: Subscription where S.Input == String? {
    private var subscriber: S?
    private weak var textField: Control?

    init(subscriber: S, textField: Control) {
      self.subscriber = subscriber
      self.textField = textField
      textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
      subscriber = nil
    }

    @objc private func textDidChange() {
      _ = subscriber?.receive(textField?.text)
    }
  }
}

