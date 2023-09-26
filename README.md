# Forms
[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
![License](https://img.shields.io/badge/License-MIT-blue)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrunomunizaf%2FForms%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brunomunizaf/Forms)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrunomunizaf%2FForms%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brunomunizaf/Forms)

Forms provides a collection of reusable form components, including text items, input fields, checkboxes, buttons, and spacing elements, designed to simplify the integration of forms into your iOS apps. With a focus on flexibility and ease of use, this library empowers developers to create beautiful and interactive forms **effortlessly**. Whether you're building a registration page or a settings screen, the Forms Library is here to streamline your development process and enhance your app's user experience.

## Installing Forms
### Swift Package Manager

To install Forms using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the Forms repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/brunomunizaf/Forms

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/brunomunizaf/Forms.git", from: "0.1.0")
```

## Creating a Form

```swift
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
  subtitle: "Terms and conditions may apply. For your safety, please ... etc etc",
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

let formView = Form(
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
// Setup constraints...
```

## Contributing

To make changes to the project, you can clone the repo and open `Package.swift`.

Would be nice if all pull requests with new features or bug fixes would include unit test cases that validate the included changes. You can use the **FormsTests** target for this.
