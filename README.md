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
.package(url: "https://github.com/brunomunizaf/Forms.git", from: "0.1.4")
```

## Creating a Form

You can instantiate a `FormView` programatically or use it as a custom class for a UIView on either a storyboard or a xib and connect it through an `@IBOutlet`.

```swift
import Forms
import UIKit

final class ViewController: UIViewController {
  @IBOutlet weak var formView: FormView!

  override func viewDidLoad() {
    super.viewDidLoad()

    formView.add(
      FormTextItem(
       text: "Personal details"
    ))
}
```

Each `FormItem` can be customized to look however you need

```swift
FormTextItem(
  text: "Create a new password",
  font: UIFont(name: "Helvetica-bold", size: 35)!,
  color: .black,
  spacingAfter: 15
)

FormTextItem(
  text: "Your new password must be unique therefore different than the previously used.",
  attributes: [
    .font: UIFont(name: "Helvetica", size: 13)!,
    .foregroundColor: UIColor.gray,
    .kern: 0.1
  ],
  spacingAfter: 30
)
```

You can also easily listen for taps on instances of `FormButtonItem` since it is a subclass of `UIControl`

```swift
let buttonItem = FormButtonItem(title: "Continue")
buttonItem.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)

@objc func didTapOnButton() {
  // TODO: ...
}
```

When it comes to `FormCheckboxItem`, to be notified of whenever the state changes, implement an optional closure:

```swift
let checkboxItem = FormCheckboxItem(title: "Accept terms & conditions")
checkboxItem.didSelect = {
  // TODO: ...
}
```

If you're trying to validate the content inside of a text field, the `FormInputField` is perfect for this. All you have to do is to implement the `didChange` closure in order to be notified anytime the content changes.


```swift
let inputItem = FormInputItem(title: "Street Address")
inputItem.didChange = {
  // TODO: ...
}
```

Also, about the `FormInputItem`, it conforms to a protocol called `FormInputType`, which means we can access the value that the user inserted by simply accessing its `.value` property.

## Custom items

In the example project, you can find a few examples of using custom implementations of UIView\`s that conform to the `FormItem` protocol. Most of the examples you'll find here are related to validations - which are very common when it comes to forms such as in registration flows.

```swift
final class MinimumFormInputItem: FormInputItem, Validatable {
  var isValid: Bool {
    if let value {
      return !value.isEmpty
    } else {
      return false
    }
  }
}

final class RegexFormInputItem: FormInputItem, Validatable {
  var isValid: Bool {
    guard let value else { return false }

    let regexPattern = "^[0-9]+$"
    do {
      let regex = try NSRegularExpression(pattern: regexPattern)
      let range = NSRange(value.startIndex..., in: value)
      let isMatch = regex.firstMatch(in: value, options: [], range: range) != nil
      return isMatch
    } catch {
      return false
    }
  }
}

final class RequiredFormCheckboxItem: FormCheckboxItem, Validatable {
  var isValid: Bool { isSelected }
}

```

The `Validatable` protocol simply gives us a `isValid` boolean property that has its own implementation on whoever conforms to it. Meaning you can have different kinds of rules for different inputs.

Thanks to this protocol, we can map through the items in a form to validate all of them and do things like enabled/disable a continue button for example.

```swift
public var isValid: Bool {
  elements
    .compactMap { $0 as? Validatable }
    .allSatisfy { $0.isValid }
}
```

## Contributing

To make changes to the project, you can clone the repo and open `Package.swift`.

Would be nice if all pull requests with new features or bug fixes would include unit test cases that validate the included changes. You can use the **FormsTests** target for this.
