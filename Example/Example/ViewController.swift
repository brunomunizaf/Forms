import Combine
import Forms
import UIKit

/// `ViewController` is a `UIViewController` subclass that manages the
/// interactions and lifecycle events of the main view of the app.
final class ViewController: UIViewController {
  // MARK: - Properties

  /// A lazy initialized `ScreenView` object.
  lazy var screenView = ScreenView()

  /// A cancellable object that represents a type-erasing
  /// reference-holding container that stores the produced cancellables.
  private var cancellables = Set<AnyCancellable>()

  // MARK: - Lifecycle

  override func loadView() {
    view = screenView
  }

  deinit {
    // Removing the view controller as an observer.
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Setting up observers and actions
    setupObservers()
    setupActions()
  }

  // MARK: - Setup

  /// Sets up observers and subscriptions
  private func setupObservers() {
    setupSubscriptions()
    setupKeyboardObservers()
  }

  /// The subscriptions are stored in the `cancellables` set to keep them alive.
  private func setupSubscriptions() {
    /// Subscribes to `isEnabledPublisher` from `FormButtonItem`.
    /// When `isEnabled` state changes, it receives a signal with the value
    screenView
      .buttonItem
      .isEnabledPublisher
      .removeDuplicates() // To avoid spamming the console
      .sink { print($0 ? "FormButtonItem: 👍🏻" : "FormButtonItem: 👎🏻") }
      .store(in: &cancellables)

    /// Subscribes to `isSelectedPublisher` from `FormCheckboxItem`.
    /// When `isSelected` state changes, it receives a signal with the value
    screenView
      .checkboxItem
      .isSelectedPublisher
      .removeDuplicates() // To avoid spamming the console
      .sink { print($0 ? "FormCheckboxItem: ✅" : "FormCheckboxItem: ⬜️") }
      .store(in: &cancellables)

    /// Subscribes to `tapPublisher` from custom extension
    /// located at `CombinePublisher.swift`.
    screenView
      .buttonItem
      .tapPublisher
      .sink { print("Tapped on FormButtonItem. <> This observation was set using Publishers! 🫡") }
      .store(in: &cancellables)
  }

  /// Sets up observers for keyboard notifications.
  private func setupKeyboardObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self, selector: #selector(adjustForKeyboard),
      name: UIResponder.keyboardWillHideNotification, object: nil
    )
    notificationCenter.addObserver(
      self, selector: #selector(adjustForKeyboard),
      name: UIResponder.keyboardWillChangeFrameNotification, object: nil
    )
  }

  /// Sets up target-action for buttons and other UI components.
  private func setupActions() {
    screenView.inputItem.didChange = { [weak self] in
      if let text = $0 {
        print(">>> 'inputItem' = \(text)")
      }
      self?.validateForm()
    }
    screenView.numbersInputItem.didChange = { [weak self] in
      if let text = $0 {
        print(">>> 'numbersInputItem' = \(text)")
      }
      self?.validateForm()
    }
    screenView.requiredInputItem.didChange = { [weak self] in
      if let text = $0 {
        print(">>> 'requiredInputItem' = \(text)")
      }
      self?.validateForm()
    }

    screenView.checkboxItem.didSelect = { [weak self] in
      self?.validateForm()
    }
    screenView.buttonItem.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
  }

  // MARK: - Validation

  /// Validates the form and updates the UI accordingly.
  func validateForm() {
    screenView.buttonItem.isEnabled = screenView.formView.isValid
  }

  // MARK: - Actions

  /// Handles the button tap event and performs the associated actions.
  @objc func didTapButton() {
    print("Tapped on FormButtonItem! <> This observation was set using Selectors. 🤷🏻‍♂️")
  }

  /// Adjusts the scrollView’s content inset when the keyboard appears or disappears.
  @objc func adjustForKeyboard(notification: Notification) {
    // Extracting necessary information from the notification object.
    guard let userInfo = notification.userInfo,
          let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
          let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
          let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
          let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRaw) else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    // Adjusting contentInset and scrollIndicatorInsets based on the keyboard's presence.
    if notification.name == UIResponder.keyboardWillHideNotification {
      animateKeyboardAdjustment(duration: animationDuration, curve: animationCurve) {
        self.screenView.scrollView.contentInset = .zero
      }
    } else {
      animateKeyboardAdjustment(duration: animationDuration, curve: animationCurve) {
        self.screenView.scrollView.contentInset = UIEdgeInsets(
          top: 0, left: 0, bottom: keyboardViewEndFrame.height - self.view.safeAreaInsets.bottom, right: 0
        )
      }
    }
    screenView.scrollView.scrollIndicatorInsets = screenView.scrollView.contentInset
  }

  /// Animates keyboard adjustments with the given parameters.
  private func animateKeyboardAdjustment(duration: Double, curve: UIView.AnimationCurve, animations: @escaping () -> Void) {
    UIView.animate(withDuration: duration, delay: 0.0, options: [.beginFromCurrentState, curve.animationOption], animations: animations, completion: nil)
  }
}

// MARK: - UIView.AnimationCurve Extension

extension UIView.AnimationCurve {
  var animationOption: UIView.AnimationOptions {
    switch self {
    case .easeIn:
      return .curveEaseIn
    case .easeOut:
      return .curveEaseOut
    case .easeInOut:
      return .curveEaseInOut
    default:
      return .curveLinear
    }
  }
}
