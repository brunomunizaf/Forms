import Forms
import UIKit

// MARK: - FormInputItem

extension FormInputItem.Configuration {
  static func with(
    title: String,
    placeholder: String
  ) -> FormInputItem.Configuration {
    FormInputItem.Configuration(
      title: [
        NSAttributedString(
          string: title,
          attributes: [
            .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
            .foregroundColor: UIColor.label
          ])
      ],
      initialText: nil,
      placeholder: [
        NSAttributedString(
          string: placeholder,
          attributes: [
            .foregroundColor: UIColor.tertiaryLabel,
            .font: UIFont(name: "AvenirNext-Regular", size: 16)!
          ])
      ],
      isSecure: false,
      autocorrectionType: .no,
      autocapitalizationType: .none,
      font: UIFont(name: "AvenirNext-Regular", size: 16)!,
      textColor: UIColor.label,
      cornerRadius: 8,
      borderWidth: 1.0,
      borderColor: UIColor.systemGray,
      spacingAfter: 15,
      didChange: nil
    )
  }
}


// MARK: - FormSwitchItem

extension FormSwitchItem.Configuration {
  static func with(
    title: String,
    subtitle: String
  ) -> FormSwitchItem.Configuration {
    FormSwitchItem.Configuration(
      title: [
        NSAttributedString(
          string: title,
          attributes: [
            .foregroundColor: UIColor.label,
            .font: UIFont(name: "AvenirNext-Medium", size: 17)!
          ])
      ],
      subtitle: [
        NSAttributedString(
          string: subtitle,
          attributes: [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont(name: "AvenirNext-Regular", size: 15)!
          ])
      ],
      onColor: .systemBlue,
      isOn: false,
      spacingAfter: 25
    )
  }
}

// MARK: FormCheckboxItem

extension FormCheckboxItem.Configuration {
  static func with(
    title: String,
    subtitle: String,
    highlightedSubtitle: String
  ) -> FormCheckboxItem.Configuration {
    FormCheckboxItem.Configuration(
      title: [
        NSAttributedString(
          string: title,
          attributes: [
            .foregroundColor: UIColor.label,
            .font: UIFont(name: "AvenirNext-Medium", size: 18)!
          ])
      ],
      subtitle: [
        NSAttributedString(
          string: subtitle,
          attributes: [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont(name: "AvenirNext-Regular", size: 14)!
          ]),
        NSAttributedString(
          string: highlightedSubtitle,
          attributes: [
            .foregroundColor: UIColor.secondaryLabel,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont(name: "AvenirNext-Regular", size: 14)!
          ])
      ],
      checkedColor: UIColor.systemGreen,
      uncheckedColor: UIColor.white,
      borderWidth: 1.0,
      borderColor: UIColor.lightGray,
      cornerRadius: 5.0,
      isChecked: false,
      spacingAfter: 20.0,
      shouldBeSelected: false
    )
  }
}

// MARK: FormTextItem

extension FormTextItem.Configuration {
  static func h1(_ title: String) -> FormTextItem.Configuration {
    FormTextItem.Configuration(
      text: [
        NSAttributedString(
          string: title,
          attributes: [
            .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
            .foregroundColor: UIColor.label,
            .kern: 0.5
          ])
      ],
      spacingAfter: 20
    )
  }

  static func h2(_ title: String) -> FormTextItem.Configuration {
    FormTextItem.Configuration(
      text: [
        NSAttributedString(
          string: title,
          attributes: [
            .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
            .foregroundColor: UIColor.secondaryLabel,
            .kern: 0.2
          ])
      ],
      spacingAfter: 20
    )
  }
}

// MARK: FormButtonItem

extension FormButtonItem.Configuration {
  static func withTitle(_ title: String) -> FormButtonItem.Configuration {
    FormButtonItem.Configuration(
      title: [
        NSAttributedString(
          string: title,
          attributes: [
            .font: UIFont(name: "AvenirNext-Bold", size: 20)!,
            .foregroundColor: UIColor.white
          ])
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
}
