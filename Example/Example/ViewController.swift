import Forms
import UIKit

final class ViewController: UIViewController {
  lazy var screenView = ScreenView()

  override func loadView() {
    view = screenView
  }

  deinit { NotificationCenter.default.removeObserver(self) }

  override func viewDidLoad() {
    super.viewDidLoad()

    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(
      self, selector: #selector(adjustForKeyboard),
      name: UIResponder.keyboardWillHideNotification, object: nil
    )
    notificationCenter.addObserver(
      self, selector: #selector(adjustForKeyboard),
      name: UIResponder.keyboardWillChangeFrameNotification, object: nil
    )

    screenView.buttonItem
      .addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

    screenView.checkboxItem.didSelect = { [weak self] in
      guard let self else { return }
      self.validate()
    }

    screenView.inputItem.didChange = { [weak self] in
      guard let self else { return }
      self.validate()
    }

    screenView.numbersInputItem.didChange = { [weak self] in
      guard let self else { return }
      self.validate()
    }

    screenView.requiredInputItem.didChange = { [weak self] in
      guard let self else { return }
      self.validate()
    }
  }

  func validate() {
    screenView.buttonItem.isEnabled = screenView.formView.isValid
  }

  @objc func didTapButton() {
    print("1_\(screenView.inputItem.value ?? "")")
    print("2_\(screenView.requiredInputItem.value ?? "")")
    print("3_\(screenView.numbersInputItem.value ?? "")")
  }

  @objc func adjustForKeyboard(notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
          let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
          let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
          let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRaw) else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
      UIView.animate(
        withDuration: animationDuration,
        delay: 0.0,
        options: [.beginFromCurrentState, animationCurve.animationOption],
        animations: { self.screenView.scrollView.contentInset = .zero },
        completion: nil
      )
    } else {
      UIView.animate(
        withDuration: animationDuration,
        delay: 0.0,
        options: [.beginFromCurrentState, animationCurve.animationOption],
        animations: {
          self.screenView.scrollView.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: keyboardViewEndFrame.height - self.view.safeAreaInsets.bottom, right: 0
          )
        },
        completion: nil
      )
    }

    screenView.scrollView.scrollIndicatorInsets = screenView.scrollView.contentInset
  }
}

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
