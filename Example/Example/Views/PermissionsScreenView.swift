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
  let secondSwitchItem = FormSwitchItem(configuration: .second)
  let thirdSwitchItem = FormSwitchItem(configuration: .third)
  let buttonItem = FormButtonItem(configuration: .terms)

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
  static let permissionsTitle = FormTextItem.Configuration(
    text: "Manage Permissions",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
      .foregroundColor: UIColor.black,
      .kern: 0.5
    ],
    spacingAfter: 20
  )

  static let permissionsSubtitle = FormTextItem.Configuration(
    text: "Customize which features the app can access to enhance your user experience.",
    attributes: [
      .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
      .foregroundColor: UIColor.darkGray,
      .kern: 0.2
    ],
    spacingAfter: 20
  )
}

private extension FormSwitchItem.Configuration {
  static let first = FormSwitchItem.Configuration(
    title: "Location Access",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 17)!,
    titleColor: .black,
    subtitle: "Allow the app to access your location to enhance service delivery and improve user experience.",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 15)!,
    subtitleColor: .gray,
    onColor: .systemBlue,
    isOn: false,
    spacingAfter: 25
  )

  static let second = FormSwitchItem.Configuration(
    title: "Notifications",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 17)!,
    titleColor: .black,
    subtitle: "Enable notifications to stay updated with the latest news, updates, and offers.",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 15)!,
    subtitleColor: .gray,
    onColor: .systemGreen,
    isOn: false,
    spacingAfter: 25
  )

  static let third = FormSwitchItem.Configuration(
    title: "Camera Access",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 17)!,
    titleColor: .black,
    subtitle: "Grant permission to access your camera to take photos and videos within the app.",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 15)!,
    subtitleColor: .gray,
    onColor: .systemRed,
    isOn: false,
    spacingAfter: 25
  )
}

private extension FormButtonItem.Configuration {
  static let terms = FormButtonItem.Configuration(
    title: "Continue to T&C",
    font: UIFont(name: "AvenirNext-Bold", size: 20)!,
    textColor: UIColor.white,
    enabledColor: UIColor.systemBlue,
    disabledColor: UIColor.systemGray,
    borderWidth: 1.0,
    borderColor: UIColor.clear,
    cornerRadius: 10.0,
    spacingAfter: 0,
    shouldBeEnabled: true
  )
}
