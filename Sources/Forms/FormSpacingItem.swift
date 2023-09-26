import UIKit

public final class FormSpacingItem: UIView, FormItem {
  public var type: FormItemType { .spacing }

  public var spacingAfter: CGFloat { 0 }

  public init(fixedHeight: CGFloat? = nil) {
    super.init(frame: .zero)

    translatesAutoresizingMaskIntoConstraints = false
    setContentHuggingPriority(.defaultLow, for: .vertical)
    setContentHuggingPriority(.defaultLow, for: .horizontal)

    if let fixedHeight {
      heightAnchor.constraint(
        equalToConstant: fixedHeight
      ).isActive = true
    }
  }
  
  required init?(coder: NSCoder) { nil }
}
