import UIKit

open class FormButtonItem: UIControl, FormItem {
  private let titleLabel = UILabel()
  private let enabledColor: UIColor
  private let disabledColor: UIColor

  public let spacingAfter: CGFloat

  open override var isEnabled: Bool {
    get { super.isEnabled }
    set {
      super.isEnabled = newValue
      backgroundColor = newValue ? enabledColor : disabledColor
    }
  }

  public init(
    title: String,
    font: UIFont = .boldSystemFont(ofSize: 14),
    textColor: UIColor = .black,
    enabledColor: UIColor = .green,
    disabledColor: UIColor = .white,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .clear,
    cornerRadius: CGFloat = 10.0,
    spacingAfter: CGFloat = 0,
    shouldBeEnabled: Bool = true
  ) {
    self.titleLabel.font = font
    self.titleLabel.text = title
    self.titleLabel.textColor = textColor
    self.spacingAfter = spacingAfter
    self.enabledColor = enabledColor
    self.disabledColor = disabledColor

    super.init(frame: .zero)

    layer.borderWidth = borderWidth
    layer.cornerRadius = cornerRadius
    layer.borderColor = borderColor.cgColor
    self.isEnabled = shouldBeEnabled

    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 10).isActive = true
    titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -10).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
  }
  
  required public init?(coder: NSCoder) { nil }
}
