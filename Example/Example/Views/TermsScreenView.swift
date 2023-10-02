import Forms
import UIKit

/// `TermsScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Terms and Conditions UI flow.
///
final class TermsScreenView: UIView {
  // MARK: - Properties
  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .termsTitle),
    FormTextItem(configuration: .termsSubtitle),
    FormSpacingItem(),
    checkboxItem,
    buttonItem
  ])

  let buttonItem = FormButtonItem(configuration: .terms)
  let checkboxItem = RequiredFormCheckboxItem(configuration: .terms)

  init() {
    super.init(frame: .zero)
    backgroundColor = .white

    addSubview(formView)
    formView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      formView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      formView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      formView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      formView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      formView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
    ])
  }

  required init?(coder: NSCoder) { nil }
}

// MARK: - FormItem.Configuration

private extension FormTextItem.Configuration {
  static let termsTitle = FormTextItem.Configuration(
    text: "Review Our Terms & Conditions",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
      .foregroundColor: UIColor.black,
      .kern: 0.5
    ],
    spacingAfter: 20
  )

  static let termsSubtitle = FormTextItem.Configuration(
    text: "Please read carefully to understand your rights and obligations while using our services.",
    attributes: [
      .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
      .foregroundColor: UIColor.darkGray,
      .kern: 0.2
    ],
    spacingAfter: 20
  )
}

private extension FormCheckboxItem.Configuration {
  static let terms = FormCheckboxItem.Configuration(
    title: "Acceptance of Terms & Conditions",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 18)!,
    titleColor: UIColor.black,
    subtitle: "By checking this box, you acknowledge that you have read, understood, and agree to abide by the terms and conditions outlined above.",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 14)!,
    subtitleColor: UIColor.gray,
    checkedColor: UIColor.systemGreen,
    uncheckedColor: UIColor.white,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    cornerRadius: 5.0,
    isSelected: false,
    spacingAfter: 20.0,
    shouldBeSelected: false
  )
}

private extension FormButtonItem.Configuration {
  static let terms = FormButtonItem.Configuration(
    title: "Continue to Registration",
    font: UIFont(name: "AvenirNext-Bold", size: 20)!,
    textColor: UIColor.white,
    enabledColor: UIColor.systemBlue,
    disabledColor: UIColor.systemGray,
    borderWidth: 1.0,
    borderColor: UIColor.clear,
    cornerRadius: 10.0,
    spacingAfter: 0,
    shouldBeEnabled: false
  )
}
