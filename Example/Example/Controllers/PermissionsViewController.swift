import Combine
import Forms
import UIKit

/// `PermissionsViewController` is a `UIViewController` subclass that manages the
/// interactions and lifecycle events of the `PermissionsScreenView` of the app.
///
final class PermissionsViewController: UIViewController {
  // MARK: - Properties

  /// A lazy initialized `PermissionsScreenView` object
  lazy var screenView = PermissionsScreenView()

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

  // MARK: - Private

  private func setupSubscriptions() {
    /// Subscribes to `.touchUpInsidePublisher` from custom extension
    /// located at `UIControl+Publishers.swift`.
    screenView
      .buttonItem
      .touchUpInsidePublisher
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] _ in performSegue(withIdentifier: "segueToTerms", sender: nil) }
      .store(in: &cancellables)

    /// Subscribes to `.valueChangedPublisher` from custom extension
    /// located at `UIControl+Publishers.swift`
    screenView
      .firstSwitchItem
      .isOnPublisher
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] in
        print(">>> 1st FormSwitchItem \($0 ? "on" : "off")")
        validateForm()
      }
      .store(in: &cancellables)

    /// Subscribes to `.valueChangedPublisher` from custom extension
    /// located at `UIControl+Publishers.swift`
    screenView
      .secondSwitchItem
      .isOnPublisher
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] in
        print(">>> 2nd FormSwitchItem \($0 ? "on" : "off")")
        validateForm()
      }
      .store(in: &cancellables)

    /// Subscribes to `.valueChangedPublisher` from custom extension
    /// located at `UIControl+Publishers.swift`
    screenView
      .thirdSwitchItem
      .isOnPublisher
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] in
        print(">>> 3rd FormSwitchItem \($0 ? "on" : "off")")
        validateForm()
      }
      .store(in: &cancellables)
  }

  // MARK: - Validation

  /// Validates the form and updates the UI accordingly.
  func validateForm() {
    screenView.buttonItem.isEnabled = screenView.formView.isValid
  }
}
