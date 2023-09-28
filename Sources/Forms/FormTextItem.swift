import UIKit

/// `FormTextItem` represents a text item in a form. It is a customizable `UIView`
/// with a label and conforms to the `FormItem` protocol.
open class FormTextItem: UIView, FormItem {
  private let textLabel = UILabel()

  /// The space after the text item in the form.
  public let spacingAfter: CGFloat

  /// Initializes a new instance of `FormTextItem` with the provided text attributes.
  /// - Parameters:
  ///   - text: The text of the item.
  ///   - attributes: The attributes to apply to the text.
  ///   - spacingAfter: The space after the text item in the form.
  public init(text: String, attributes: [NSAttributedString.Key: Any], spacingAfter: CGFloat) {
    textLabel.numberOfLines = 0
    textLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupSubviews()

    // Improving accessibility
    textLabel.accessibilityLabel = text
    textLabel.accessibilityTraits = .staticText
  }

  /// Initializes a new instance of `FormTextItem` with the provided text and style.
  /// - Parameters:
  ///   - text: The text of the item.
  ///   - font: The font of the text label.
  ///   - color: The text color of the text label.
  ///   - spacingAfter: The space after the text item in the form.
  public init(text: String, font: UIFont, color: UIColor, spacingAfter: CGFloat) {
    textLabel.text = text
    textLabel.font = font
    textLabel.textColor = color
    textLabel.numberOfLines = 0
    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupSubviews()

    // Improving accessibility
    textLabel.accessibilityLabel = text
    textLabel.accessibilityTraits = .staticText
  }

  required public init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    textLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
