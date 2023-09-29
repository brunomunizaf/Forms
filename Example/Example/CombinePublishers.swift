import Combine
import UIKit

extension UIControl {
  var tapPublisher: AnyPublisher<Void, Never> {
    Publishers
      .ControlTarget(
        control: self,
        events: .touchUpInside
      )
      .eraseToAnyPublisher()
  }
}

extension Publishers {
  struct ControlTarget<OuterControl: UIControl>: Publisher {
    typealias Output = Void
    typealias Failure = Never

    private let control: OuterControl
    private let controlEvents: OuterControl.Event

    init(control: OuterControl, events: OuterControl.Event) {
      self.control = control
      self.controlEvents = events
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = Subscription(subscriber: subscriber, control: control, event: controlEvents)
      subscriber.receive(subscription: subscription)
    }

    private final class Subscription<S: Subscriber, InnerControl: UIControl>: Combine.Subscription where S.Input == Void {
      private var subscriber: S?
      private weak var control: InnerControl?

      init(subscriber: S, control: InnerControl, event: InnerControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
      }

      func request(_ demand: Subscribers.Demand) {}

      func cancel() {
        subscriber = nil
      }

      @objc private func eventHandler() {
        _ = subscriber?.receive(())
      }
    }
  }
}
