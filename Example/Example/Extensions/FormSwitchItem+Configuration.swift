import Forms
import UIKit

extension FormSwitchItem.Configuration {
  static let regularStyle = FormSwitchItem.Configuration(
    title: "Subscribe to updates",
    titleFont: UIFont(name: "Helvetica-bold", size: 16)!,
    titleColor: .black,
    subtitle: "Subscribing to weekly updates from CISA.gov and NSA/CIA",
    subtitleFont: UIFont(name: "Helvetica-light", size: 13)!,
    subtitleColor: .lightGray,
    onColor: .systemOrange,
    isOn: false,
    spacingAfter: 25
  )

  static let elegantModern = FormSwitchItem.Configuration(
    title: "Enable Dark Mode",
    titleFont: UIFont(name: "AvenirNext-DemiBold", size: 17)!,
    titleColor: .darkGray,
    subtitle: "Switch to dark mode for a more eye-friendly interface at night",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 14)!,
    subtitleColor: .lightGray,
    onColor: .black,
    isOn: false,
    spacingAfter: 15
  )

  static let boldColorful = FormSwitchItem.Configuration(
    title: "Activate Fun Mode",
    titleFont: UIFont(name: "Chalkduster", size: 16)!,
    titleColor: .systemPink,
    subtitle: "Unleash colorful and lively interface elements and animations",
    subtitleFont: UIFont(name: "MarkerFelt-Thin", size: 13)!,
    subtitleColor: .systemTeal,
    onColor: .systemPurple,
    isOn: false,
    spacingAfter: 20
  )

  static let subduedProfessional = FormSwitchItem.Configuration(
    title: "Enable Notifications",
    titleFont: UIFont(name: "Palatino-Bold", size: 16)!,
    titleColor: .systemGray,
    subtitle: "Receive timely updates and important alerts",
    subtitleFont: UIFont(name: "Palatino-Italic", size: 14)!,
    subtitleColor: .systemGray2,
    onColor: .systemBlue,
    isOn: true,
    spacingAfter: 10
  )
}
