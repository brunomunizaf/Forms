import UIKit

/// `FinishedViewController` is a `UIViewController` subclass that manages the
/// interactions and lifecycle events of the `FinishedScreenView` of the app.
final class FinishedViewController: UIViewController {
  // MARK: - Properties

  /// A lazy initialized `FinishedScreenView` object
  lazy var screenView = FinishedScreenView()

  // MARK: - Lifecycle

  override func loadView() {
    view = screenView
  }
}
