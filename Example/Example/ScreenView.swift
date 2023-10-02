import Forms
import UIKit

/// `ScreenView` is a `UIView` subclass that sets up and 
/// manages various `FormItem`s`, including text items, a
/// checkbox item, input items, and a button item within a
/// scroll view.
///
final class ScreenView: UIView {
  // MARK: - Properties
  lazy var formView = FormView(elements: [
    titleItem,
    subtitleItem,
    inputItem,
    requiredInputItem,
    numbersInputItem,
    switchItem,
    pickerItem,
    FormSpacingItem(),
    checkboxItem,
    buttonItem
  ])
  let titleItem = FormTextItem(
    configuration: .title
  )
  let subtitleItem = FormTextItem(
    configuration: .subtitle()
  )
  let inputItem = FormInputItem(
    configuration: .first
  )
  let requiredInputItem = MinimumFormInputItem(
    configuration: .second
  )
  let numbersInputItem = RegexFormInputItem(
    configuration: .third
  )
  let pickerItem = FormPickerItem(
    configuration: .example
  )
  let switchItem = FormSwitchItem(
    configuration: .elegantModern
  )
  let checkboxItem = RequiredFormCheckboxItem(
    configuration: .modernVibrant
  )
  let buttonItem = FormButtonItem(
    configuration: .modernElegant
  )
  let scrollView = UIScrollView()

  init() {
    super.init(frame: .zero)
    backgroundColor = .white

    addSubview(scrollView)
    scrollView.addSubview(formView)
    scrollView.keyboardDismissMode = .interactive

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    formView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      formView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      formView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
      formView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
      formView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
      formView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
    ])
    let heightConstraint = formView.heightAnchor.constraint(
      equalTo: scrollView.heightAnchor, constant: -50
    )
    heightConstraint.priority = .defaultLow
    heightConstraint.isActive = true
  }

  required init?(coder: NSCoder) { nil }
}
