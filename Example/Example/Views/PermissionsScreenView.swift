import Forms
import UIKit

/// `PermissionsScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Permissions UI flow.
///
final class PermissionsScreenView: UIView {
  // MARK: - Properties

  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .h1(Strings.Permissions.title)),
    FormTextItem(configuration: .h2(Strings.Permissions.subtitle)),
    locationSwitchItem,
    notificationsSwitchItem,
    cameraSwitchItem,
    FormSpacingItem(),
    buttonItem
  ])

  let locationSwitchItem = FormSwitchItem(configuration: .with(
    title: Strings.Permissions.locationTitle,
    subtitle: Strings.Permissions.locationSubtitle
  ))
  let notificationsSwitchItem = RequiredFormSwitchItem(configuration: .init(
    title: [
      NSAttributedString(
        string: Strings.Permissions.notificationsTitle,
        attributes: [
          .foregroundColor: UIColor.label,
          .font: UIFont(name: "AvenirNext-Medium", size: 17)!
        ])
    ],
    subtitle: [
      NSAttributedString(
        string: Strings.Permissions.notificationsSubtitleA,
        attributes: [
          .foregroundColor: UIColor.secondaryLabel,
          .font: UIFont(name: "AvenirNext-Regular", size: 15)!
        ]),
      NSAttributedString(
        string: Strings.Permissions.notificationsSubtitleB,
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
  ))
  let cameraSwitchItem = FormSwitchItem(configuration: .with(
    title: Strings.Permissions.cameraTitle,
    subtitle: Strings.Permissions.cameraSubtitle
  ))
  let buttonItem = FormButtonItem(configuration: .withTitle(Strings.Permissions.button))

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
