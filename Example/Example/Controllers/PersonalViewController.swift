import Forms
import UIKit

/// `PersonalViewController` is a `UIViewController` subclass that manages the
/// interactions and lifecycle events of the `PersonalScreenView` of the app.
///
final class PersonalViewController: UIViewController {
  // MARK: - Properties

  /// A lazy initialized `PersonalScreenView` object
  lazy var screenView = PersonalScreenView()

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
    setupKeyboardObservers()
    setupActions()
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
    screenView.buttonItem.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
  }

  // MARK: - Actions

  /// Handles the button tap event and performs the associated actions.
  @objc private func didTapButton() {
    performSegue(withIdentifier: "segueToPermissions", sender: self)
  }

  // MARK: - Validation

  /// Validates the form and updates the UI accordingly.
  func validateForm() {
    screenView.buttonItem.isEnabled = screenView.formView.isValid
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
