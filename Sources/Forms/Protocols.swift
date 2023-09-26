import UIKit

public protocol FormItem: UIView {
  var spacingAfter: CGFloat { get }
}

public protocol FormInputType: FormItem {
  var value: String? { get }
}

// MARK: -

public protocol Validatable: FormItem {
  var isValid: Bool { get }
}
