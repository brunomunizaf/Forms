import UIKit

/// A protocol that defines a FormItem with spacing.
public protocol FormItem: UIView {
  /// A CGFloat value representing the spacing after the FormItem.
  var spacingAfter: CGFloat { get }
}

/// A protocol that defines a FormItem with input value.
public protocol FormInputType: FormItem {
  /// A String value representing the input value of the FormItem.
  var value: String? { get }
}

/// A protocol that defines a validatable FormItem.
public protocol Validatable: FormItem {
  /// A Boolean value indicating whether the FormItem is valid.
  var isValid: Bool { get }
}
