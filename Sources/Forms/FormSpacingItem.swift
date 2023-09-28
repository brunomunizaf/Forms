import UIKit

/// `FormSpacingItem` represents a spacer item in a form. It is a `UIView`
/// that can be used to add space between other `FormItem`s and conforms to the `FormItem` protocol.
open class FormSpacingItem: UIView, FormItem {

  /// The space after the spacing item in the form.
  public let spacingAfter: CGFloat

  /// Initializes a new instance of `FormSpacingItem`.
  /// - Parameters:
  ///   - fixedHeight: The fixed height of the spacing item. If nil, height is determined by the content.
  ///   - spacingAfter: The space after the spacing item in the form.
  public init(fixedHeight: CGFloat? = nil, spacingAfter: CGFloat = 0) {
    self.spacingAfter = spacingAfter

    super.init(frame: .zero)

    if let fixedHeight = fixedHeight {
      heightAnchor.constraint(equalToConstant: fixedHeight).isActive = true
    }
  }

  required public init?(coder: NSCoder) { nil }
}
