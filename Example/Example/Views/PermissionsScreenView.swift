import Forms
import UIKit

/// `PermissionsScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Permissions UI flow.
///
final class PermissionsScreenView: UIView {
  // MARK: - Properties

  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .permissionsTitle),
    FormTextItem(configuration: .permissionsSubtitle),
    firstSwitchItem,
    secondSwitchItem,
    thirdSwitchItem,
    FormSpacingItem(),
    buttonItem
  ])

  let firstSwitchItem = FormSwitchItem(configuration: .first)
  let secondSwitchItem = RequiredFormSwitchItem(configuration: .second)
  let thirdSwitchItem = FormSwitchItem(configuration: .third)
  let buttonItem = FormButtonItem(configuration: .terms)

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemBackground

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
  static let permissionsTitle = FormTextItem.Configuration(
    text: [
      NSAttributedString(
        string: "Manage Permissions",
        attributes: [
          .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
          .foregroundColor: UIColor.label,
          .kern: 0.5
        ])
    ],
    spacingAfter: 20
  )

  static let permissionsSubtitle = FormTextItem.Configuration(
    text: [
      NSAttributedString(
        string: "Customize which features the app can access to enhance your user experience.",
        attributes: [
          .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
          .foregroundColor: UIColor.secondaryLabel,
          .kern: 0.2
        ])
    ],
    spacingAfter: 20
  )
}

private extension FormSwitchItem.Configuration {
  static let first = FormSwitchItem.Configuration(
    title: [
      NSAttributedString(
        string: "Location Access",
        attributes: [
          .foregroundColor: UIColor.label,
          .font: UIFont(name: "AvenirNext-Medium", size: 17)!
        ]),
      NSAttributedString(
        string: " (while using the app)",
        attributes: [
          .foregroundColor: UIColor.label,
          .font: UIFont(name: "AvenirNext-Regular", size: 10)!
        ])
    ],
    subtitle: [
      NSAttributedString(
        string: "Allow the app to access your location to enhance service delivery and improve user experience.",
        attributes: [
          .foregroundColor: UIColor.secondaryLabel,
          .font: UIFont(name: "AvenirNext-Regular", size: 15)!
        ])
    ],
    onColor: .systemBlue,
    isOn: false,
    spacingAfter: 25
  )

  static let second = FormSwitchItem.Configuration(
    title: [
      NSAttributedString(
        string: "Notifications",
        attributes: [
          .foregroundColor: UIColor.label,
          .font: UIFont(name: "AvenirNext-Medium", size: 17)!
        ])
    ],
    subtitle: [
      NSAttributedString(
        string: "Enable notifications to stay updated with the latest news, updates, and offers.\n",
        attributes: [
          .foregroundColor: UIColor.secondaryLabel,
          .font: UIFont(name: "AvenirNext-Regular", size: 15)!
        ]),
      NSAttributedString(
        string: "Enabling this permission is required.",
        attributes: [
          .foregroundColor: UIColor.secondaryLabel,
          .underlineStyle: NSUnderlineStyle.single.rawValue,
          .underlineColor: UIColor.secondaryLabel,
          .font: UIFont(name: "AvenirNext-Medium", size: 14)!
        ])
    ],
    onColor: .systemGreen,
    isOn: false,
    spacingAfter: 25
  )

  static let third = FormSwitchItem.Configuration(
    title: [
      NSAttributedString(
        string: "Camera Access",
        attributes: [
          .foregroundColor: UIColor.label,
          .font: UIFont(name: "AvenirNext-Medium", size: 17)!
        ])
    ],
    subtitle: [
      NSAttributedString(
        string: "Grant permission to access your camera to take photos and videos within the app.",
        attributes: [
          .foregroundColor: UIColor.secondaryLabel,
          .font: UIFont(name: "AvenirNext-Regular", size: 15)!
        ])
    ],
    onColor: .systemRed,
    isOn: false,
    spacingAfter: 25
  )
}

private extension FormButtonItem.Configuration {
  static let terms = FormButtonItem.Configuration(
    title: "Continue to T&C",
    attributes: [
      .font: UIFont(name: "AvenirNext-Bold", size: 20)!,
      .foregroundColor: UIColor.white
    ],
    enabledColor: UIColor.systemBlue,
    disabledColor: UIColor.systemGray,
    borderWidth: 1.0,
    borderColor: UIColor.clear,
    cornerRadius: 10.0,
    spacingAfter: 0,
    shouldBeEnabled: false
  )
}
