import Forms
import UIKit

/// `ScreenView` is a `UIView` subclass that sets up and manages various `FormItem`s`,
/// including text items, a checkbox item, input items, and a button item within a scroll view.
final class ScreenView: UIView {
  // MARK: - Properties
  var formView = FormView(elements: [])
  var titleItem: FormTextItem!
  var subtitleItem: FormTextItem!
  var inputItem: FormInputItem!
  var requiredInputItem: MinimumFormInputItem!
  var numbersInputItem: RegexFormInputItem!
  var pickerItem: FormPickerItem!
  let switchItem = FormSwitchItem(configuration: .elegantModern)
  let checkboxItem = RequiredFormCheckboxItem(configuration: .modernVibrant)
  let buttonItem = FormButtonItem(configuration: .modernElegant)
  let scrollView = UIScrollView()

  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    backgroundColor = .white
    setupTextItems()
    setupInputItems()
    setupPickerItems()
    setupFormView()
    setupScrollView()
    setupConstraints()
  }

  required init?(coder: NSCoder) { nil }

  // MARK: - Setup Methods
  // Setup text items with appropriate attributes.
  private func setupTextItems() {
    titleItem = FormTextItem(
      text: "Create a new password",
      font: UIFont(name: "Helvetica-bold", size: 35)!,
      color: .black,
      spacingAfter: 15
    )

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4

    subtitleItem = FormTextItem(
      text: "Your new password must be unique therefore different than the previously used.",
      attributes: [
        .font: UIFont(name: "Helvetica", size: 13)!,
        .foregroundColor: UIColor.gray,
        .kern: 0.1,
        .paragraphStyle: paragraphStyle
      ],
      spacingAfter: 30
    )
  }

  // Setup input items with appropriate attributes and placeholders.
  private func setupInputItems() {
    inputItem = FormInputItem(
      title: "Street Address",
      titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
      titleColor: .black,
      placeholder: "ex: 5912 5th Avenue, New York, NY",
      isSecure: false,
      autocorrectionType: .no,
      autocapitalizationType: .none,
      font: UIFont(name: "Helvetica", size: 15)!,
      cornerRadius: 10,
      borderWidth: 1,
      borderColor: .lightGray
    )
    requiredInputItem = MinimumFormInputItem(
      title: "Full name",
      titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
      titleColor: .black,
      placeholder: "Required",
      font: UIFont(name: "Helvetica", size: 15)!,
      cornerRadius: 10,
      borderWidth: 1,
      borderColor: .lightGray
    )
    numbersInputItem = RegexFormInputItem(
      title: "Phone number",
      titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
      titleColor: .black,
      placeholder: "Only numbers allowed",
      font: UIFont(name: "Helvetica", size: 15)!,
      cornerRadius: 10,
      borderWidth: 1,
      borderColor: .lightGray,
      spacingAfter: 25
    )
  }

  // Setup picker items with appropriate attributes.
  private func setupPickerItems() {
    pickerItem = FormPickerItem(
      options: [
        ["1", "2", "3", "4"],
        ["5", "6", "7", "8"],
        ["9", "10", "11", "12"],
        ["13", "14", "15", "16"]
      ],
      selectedOption: nil
    )
  }

  // Setup form view and add form items to it.
  private func setupFormView() {
    formView.add(titleItem)
    formView.add(subtitleItem)
    formView.add(inputItem)
    formView.add(requiredInputItem)
    formView.add(numbersInputItem)
    formView.add(switchItem)
    formView.add(pickerItem)
    formView.add(FormSpacingItem())
    formView.add(checkboxItem)
    formView.add(buttonItem)
  }

  // Setup scroll view and add form view to it.
  private func setupScrollView() {
    addSubview(scrollView)
    scrollView.addSubview(formView)
    scrollView.keyboardDismissMode = .interactive
  }

  // Setup constraints for layouting subviews properly.
  private func setupConstraints() {
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
}
