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
.package(url: "https://github.com/brunomunizaf/Forms.git", from: "0.1.3")
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

Each `FormItem` can be customized to look however you like

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

## Contributing

To make changes to the project, you can clone the repo and open `Package.swift`.

Would be nice if all pull requests with new features or bug fixes would include unit test cases that validate the included changes. You can use the **FormsTests** target for this.
