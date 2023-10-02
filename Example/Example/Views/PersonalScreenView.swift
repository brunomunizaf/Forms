import Forms
import UIKit

/// `PersonalScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Personal Details UI flow.
///
final class PersonalScreenView: UIView {
  // MARK: - Properties

  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .title),
    FormTextItem(configuration: .subtitle),
    inputItem,
    requiredInputItem,
    numbersInputItem,
    FormSpacingItem(),
    buttonItem
  ])
  let inputItem = FormInputItem(configuration: .first)
  let requiredInputItem = MinimumFormInputItem(configuration: .second)
  let numbersInputItem = RegexFormInputItem(configuration: .third)
  let buttonItem = FormButtonItem(configuration: .personal)

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

private extension FormTextItem.Configuration {
  static let title = FormTextItem.Configuration(
    text: "Your personal details",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
      .foregroundColor: UIColor.black,
      .kern: 0.5
    ],
    spacingAfter: 15
  )

  static let subtitle = FormTextItem.Configuration(
    text: "Insert your personal information to keep your profile up to date.",
    attributes: [
      .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
      .foregroundColor: UIColor.darkGray,
      .kern: 0.2
    ],
    spacingAfter: 30
  )
}

private extension FormInputItem.Configuration {
  static let first = FormInputItem.Configuration(
    title: "Street Address",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 16)!,
    titleColor: UIColor.black,
    initialText: nil,
    placeholder: "e.g. 5912 5th Avenue, New York, NY",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.darkGray,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    spacingAfter: 15,
    didChange: nil
  )

  static let second = FormInputItem.Configuration(
    title: "Full Name",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 16)!,
    titleColor: UIColor.black,
    initialText: nil,
    placeholder: "Required",
    isSecure: false,
    autocorrectionType: .default,
    autocapitalizationType: .words,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.darkGray,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    spacingAfter: 15,
    didChange: nil
  )

  static let third = FormInputItem.Configuration(
    title: "Phone Number",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 16)!,
    titleColor: UIColor.black,
    initialText: nil,
    placeholder: "Only numbers allowed",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.darkGray,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    spacingAfter: 20,
    didChange: nil
  )
}

private extension FormButtonItem.Configuration {
  static let personal = FormButtonItem.Configuration(
    title: "Continue to Permissions",
    font: UIFont(name: "AvenirNext-DemiBold", size: 18)!,
    textColor: .white,
    enabledColor: .systemBlue,
    disabledColor: .systemGray3,
    borderWidth: 1.5,
    borderColor: .systemBlue,
    cornerRadius: 20.0,
    spacingAfter: 20,
    shouldBeEnabled: false
  )
}
