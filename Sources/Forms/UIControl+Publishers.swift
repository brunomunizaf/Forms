import Combine
import UIKit

extension UIControl {
  /// A publisher emitting tap events from this control.
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
  /// A publisher that emits a value when the specified control event occurs.
  struct ControlTarget<OuterControl: UIControl>: Publisher {
    typealias Output = Void
    typealias Failure = Never

    private let control: OuterControl
    private let controlEvents: OuterControl.Event

    /// Creates a control target publisher for the given control and event.
    /// - Parameters:
    ///   - control: The control to observe.
    ///   - events: The control events to observe.
    init(control: OuterControl, events: OuterControl.Event) {
      self.control = control
      self.controlEvents = events
    }

    /// Attaches the subscriber to the publisher.
    /// - Parameter subscriber: The subscriber to attach to this publisher.
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = Subscription(subscriber: subscriber, control: control, event: controlEvents)
      subscriber.receive(subscription: subscription)
    }

    /// The subscription class for `ControlTarget`.
    private final class Subscription<S: Subscriber, InnerControl: UIControl>: Combine.Subscription where S.Input == Void {
      private var subscriber: S?
      private weak var control: InnerControl?

      /// Initializes a subscription for the given subscriber and control.
      /// - Parameters:
      ///   - subscriber: The subscriber to receive events.
      ///   - control: The control to observe.
      ///   - event: The control event to observe.
      init(subscriber: S, control: InnerControl, event: InnerControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
      }

      /// Requests the specified number of values upon subscription.
      /// - Parameter demand: The number of values to request.
      func request(_ demand: Subscribers.Demand) {}

      /// Cancels the subscription, ending future value deliveries.
      func cancel() {
        subscriber = nil
      }

      /// Invoked for each value received from the subscription.
      @objc private func eventHandler() {
        _ = subscriber?.receive(())
      }
    }
  }
}
