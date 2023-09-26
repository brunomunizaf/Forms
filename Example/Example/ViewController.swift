import Forms
import UIKit

final class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let titleItem = FormTextItem(
      text: "Create a new password",
      font: UIFont(name: "Helvetica-bold", size: 35)!,
      color: .black,
      spacingAfter: 15
    )

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4

    let subtitleItem = FormTextItem(
      text: "Your new password must be unique therefore different than the previously used.",
      attributes: [
        .font: UIFont(name: "Helvetica", size: 13)!,
        .foregroundColor: UIColor.gray,
        .kern: 0.1,
        .paragraphStyle: paragraphStyle
      ],
      spacingAfter: 30
    )

    let checkboxItem = FormCheckboxItem(
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

    let inputFieldItem = FormInputItem(
      title: "Street Address",
      titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
      titleColor: .black,
      placeholder: "ex: 5912 5th Avenue, New York, NY",
      font: UIFont(name: "Helvetica", size: 15)!,
      cornerRadius: 10,
      borderWidth: 1,
      borderColor: .lightGray
    )

    let spacingItem = FormSpacingItem()

    let buttonItem = FormButtonItem(
      title: "Continue",
      font: UIFont(name: "Helvetica-bold", size: 18)!,
      textColor: .white,
      enabledColor: .systemTeal,
      disabledColor: .lightGray,
      borderWidth: 2,
      borderColor: .darkGray,
      cornerRadius: 30,
      isActive: true
    )

    let formView = FormView(
      elements: [
        titleItem,
        subtitleItem,
        inputFieldItem,
        spacingItem,
        checkboxItem,
        buttonItem
      ]
    )

    view.addSubview(formView)

    formView.translatesAutoresizingMaskIntoConstraints = false

    formView.topAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.topAnchor,
      constant: 20
    ).isActive = true

    formView.leftAnchor.constraint(
      equalTo: view.leftAnchor,
      constant: 30
    ).isActive = true

    formView.rightAnchor.constraint(
      equalTo: view.rightAnchor,
      constant: -30
    ).isActive = true

    formView.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: -20
    ).isActive = true
  }
}

#Preview {
  ViewController()
}
