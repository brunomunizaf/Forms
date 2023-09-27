import UIKit

public final class FormSpacingItem: UIView, FormItem {
  public let spacingAfter: CGFloat

  public init(
    fixedHeight: CGFloat? = nil,
    spacingAfter: CGFloat = 0
  ) {
    self.spacingAfter = spacingAfter
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
