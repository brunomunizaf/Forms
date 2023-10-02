import Forms
import UIKit

extension FormInputItem.Configuration {
  static let first = FormInputItem.Configuration(
    title: "Street Address",
    titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
    titleColor: .black,
    initialText: nil,
    placeholder: "ex: 5912 5th Avenue, New York, NY",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "Helvetica", size: 15)!,
    textColor: .black,
    cornerRadius: 10,
    borderWidth: 1,
    borderColor: .lightGray,
    spacingAfter: 10,
    didChange: nil
  )

  static let second = FormInputItem.Configuration(
    title: "Full name",
    titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
    titleColor: .black,
    initialText: nil,
    placeholder: "Required",
    isSecure: false,
    autocorrectionType: .default,
    autocapitalizationType: .words,
    font: UIFont(name: "Helvetica", size: 15)!,
    textColor: .black,
    cornerRadius: 10,
    borderWidth: 1,
    borderColor: .lightGray,
    spacingAfter: 10,
    didChange: nil
  )

  static let third = FormInputItem.Configuration(
    title: "Phone number",
    titleFont: UIFont(name: "Helvetica-bold", size: 15)!,
    titleColor: .black,
    initialText: nil,
    placeholder: "Only numbers allowed",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "Helvetica", size: 15)!,
    textColor: .black,
    cornerRadius: 10,
    borderWidth: 1.0,
    borderColor: .lightGray,
    spacingAfter: 25,
    didChange: nil
  )
}
