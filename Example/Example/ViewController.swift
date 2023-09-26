import Forms
import UIKit

final class ViewController: UIViewController {
  lazy var screenView = ScreenView()

  override func loadView() {
    view = screenView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

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
}
