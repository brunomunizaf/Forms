import Combine
import Forms
import UIKit

/// `TermsViewController` is a `UIViewController` subclass that manages the
/// interactions and lifecycle events of the `TermsScreenView` of the app.
///
final class TermsViewController: UIViewController {
  // MARK: - Properties

  /// A lazy initialized `TermsScreenView` object
  lazy var screenView = TermsScreenView()

  /// A cancellable object that represents a type-erasing
  /// reference-holding container that stores the produced cancellables.
  private var cancellables = Set<AnyCancellable>()

  // MARK: - Lifecycle

  override func loadView() {
    view = screenView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubscriptions()
  }

  private func setupSubscriptions() {
    /// Subscribes to `isSelectedPublisher` from `FormCheckboxItem`.
    /// When `isSelected` state changes, it receives a signal with the value
    screenView
      .checkboxItem
      .isSelectedPublisher
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] _ in screenView.buttonItem.isEnabled = screenView.formView.isValid }
      .store(in: &cancellables)

    /// Subscribes to `.touchUpInsidePublisher` from custom extension
    /// located at `UIControl+Publishers.swift`.
    screenView
      .buttonItem
      .touchUpInsidePublisher
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] in performSegue(withIdentifier: "segueToFinished", sender: nil) }
      .store(in: &cancellables)
  }
}
