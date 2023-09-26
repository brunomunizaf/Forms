import UIKit

public final class FormButtonItem: UIControl, FormItem {
  public var type: FormItemType { .button }

  public var spacingAfter: CGFloat

  public var isActive: Bool {
    didSet { backgroundColor = isActive ? enabledColor : disabledColor }
  }

  private(set) var titleLabel = UILabel()
  private(set) var enabledColor: UIColor
  private(set) var disabledColor: UIColor

  public init(
    title: String,
    font: UIFont = .boldSystemFont(ofSize: 14),
    textColor: UIColor = .black,
    enabledColor: UIColor = .green,
    disabledColor: UIColor = .white,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .clear,
    cornerRadius: CGFloat = 10.0,
    isActive: Bool = true,
    spaceAfter: CGFloat = 0
  ) {
    self.isActive = isActive
    self.titleLabel.font = font
    self.titleLabel.text = title
    self.titleLabel.textColor = textColor
    self.spacingAfter = spaceAfter
    self.enabledColor = enabledColor
    self.disabledColor = disabledColor

    super.init(frame: .zero)

    layer.borderWidth = borderWidth
    layer.cornerRadius = cornerRadius
    layer.borderColor = borderColor.cgColor
    backgroundColor = isActive ? enabledColor : disabledColor

    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 10).isActive = true
    titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -10).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
  }
  
  required init?(coder: NSCoder) { nil }
}
