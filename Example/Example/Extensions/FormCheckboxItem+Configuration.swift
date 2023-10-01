import Forms
import UIKit

extension FormCheckboxItem.Configuration {
  static let regularStyle = FormCheckboxItem.Configuration(
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
    spacingAfter: 25,
    shouldBeSelected: false
  )

  static let modernVibrant = FormCheckboxItem.Configuration(
    title: "Enable Animations",
    titleFont: UIFont(name: "AvenirNext-Medium", size: 16)!,
    titleColor: .darkText,
    subtitle: "Animations enrich user interaction and provide visual feedback",
    subtitleFont: UIFont(name: "AvenirNext-Regular", size: 13)!,
    subtitleColor: .gray,
    checkedColor: .systemBlue,
    uncheckedColor: .white,
    borderWidth: 1.0,
    borderColor: .systemBlue,
    cornerRadius: 8,
    isSelected: false,
    spacingAfter: 20,
    shouldBeSelected: false
  )

  static let elegantClassic = FormCheckboxItem.Configuration(
    title: "Subscribe to Newsletter",
    titleFont: UIFont(name: "TimesNewRomanPS-BoldMT", size: 16)!,
    titleColor: .black,
    subtitle: "Stay updated with the latest news and exclusive offers",
    subtitleFont: UIFont(name: "TimesNewRomanPS-ItalicMT", size: 13)!,
    subtitleColor: .darkGray,
    checkedColor: .systemRed,
    uncheckedColor: .clear,
    borderWidth: 1.0,
    borderColor: .darkGray,
    cornerRadius: 10,
    isSelected: false,
    spacingAfter: 15,
    shouldBeSelected: false
  )

  static let playfulColorful = FormCheckboxItem.Configuration(
    title: "Activate Rainbow Theme",
    titleFont: UIFont(name: "MarkerFelt-Wide", size: 16)!,
    titleColor: .systemPurple,
    subtitle: "Enjoy a lively and colorful interface with a rainbow palette",
    subtitleFont: UIFont(name: "ChalkboardSE-Regular", size: 13)!,
    subtitleColor: .systemTeal,
    checkedColor: .systemYellow,
    uncheckedColor: .white,
    borderWidth: 2.0,
    borderColor: .systemPink,
    cornerRadius: 12,
    isSelected: false,
    spacingAfter: 18,
    shouldBeSelected: false
  )
}
