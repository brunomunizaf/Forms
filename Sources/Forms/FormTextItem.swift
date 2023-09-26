import UIKit

public final class FormTextItem: UIView, FormItem {
  private let textLabel = UILabel()

  public let spacingAfter: CGFloat

  public init(
    text: String,
    attributes: [NSAttributedString.Key: Any],
    spacingAfter: CGFloat = 10
  ) {
    self.spacingAfter = spacingAfter
    super.init(frame: .zero)

    textLabel.numberOfLines = 0
    textLabel.attributedText = NSAttributedString(
      string: text,
      attributes: attributes
    )
    setupSubviews()
  }

  public init(
    text: String,
    font: UIFont = .systemFont(ofSize: 12),
    color: UIColor = .black,
    spacingAfter: CGFloat = 10
  ) {
    self.spacingAfter = spacingAfter

    super.init(frame: .zero)

    textLabel.font = font
    textLabel.text = text
    textLabel.textColor = color
    textLabel.numberOfLines = 0

    setupSubviews()
  }

  required init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    textLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
