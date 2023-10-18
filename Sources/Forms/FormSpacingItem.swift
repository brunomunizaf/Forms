import UIKit

/// `FormSpacingItem` represents a spacer item in a form.
///
/// As a subclass of `UIView`, it specializes in providing designated spaces or gaps
/// within form layouts, aiding in structuring and organizing form elements effectively.
/// It ensures clear separation and logical grouping of form items, enhancing the overall
/// readability and user-friendliness of form-based UIs.
///
/// - Note: This class conforms to the `FormItem` protocol.
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
