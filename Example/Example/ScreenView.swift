import Forms
import UIKit

final class ScreenView: UIView {
  var formView = FormView(elements: [])
  var titleItem: FormTextItem!
  var subtitleItem: FormTextItem!
  var checkboxItem: RequiredFormCheckboxItem!
  var inputItem: FormInputItem!
  var requiredInputItem: MinimumFormInputItem!
  var numbersInputItem: RegexFormInputItem!
  var buttonItem: FormButtonItem!

  init() {
    super.init(frame: .zero)
    backgroundColor = .white

    setupTextItems()
    setupCheckboxItem()
    setupInputItems()
    setupButtonItem()

    formView.add(titleItem)
    formView.add(subtitleItem)
    formView.add(inputItem)
    formView.add(requiredInputItem)
    formView.add(numbersInputItem)
    formView.add(FormSpacingItem())
    formView.add(checkboxItem)
    formView.add(buttonItem)

    addSubview(formView)
    formView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      formView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      formView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      formView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      formView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
    ])
  }

  required init?(coder: NSCoder) { nil }

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

  private func setupCheckboxItem() {
    checkboxItem = RequiredFormCheckboxItem(
      title: "Accept terms & conditions",
      titleFont: UIFont(name: "Helvetica-bold", size: 16)!,
      titleColor: .black,
      subtitle: "Terms and conditions may apply. For your safety, please read all the documents we provide upon the password changing topic",
      subtitleFont: UIFont(name: "Helvetica-light", size: 13)!,
      subtitleColor: .lightGray,
      checkedColor: .systemGreen,
      uncheckedColor: .clear,
      borderWidth: 1.5,
      borderColor: .lightGray,
      cornerRadius: 12,
      isSelected: false,
      spacingAfter: 25
    )
  }

  private func setupInputItems() {
    inputItem = FormInputItem(
      title: "Street Address",
      titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
      titleColor: .black,
      placeholder: "ex: 5912 5th Avenue, New York, NY",
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
      borderColor: .lightGray
    )
  }

  private func setupButtonItem() {
    buttonItem = FormButtonItem(
      title: "Continue",
      font: UIFont(name: "Helvetica-bold", size: 18)!,
      textColor: .white,
      enabledColor: .systemTeal,
      disabledColor: .lightGray,
      borderWidth: 2,
      borderColor: .darkGray,
      cornerRadius: 30,
      shouldBeEnabled: false
    )
  }
}
