import UIKit

/// `FormTextItem` represents a text item in a form.
///
/// As a subclass of `UIView`, it is designed to hold and display text content
/// within form layouts, offering extensive customization options for text attributes
/// and styles.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormTextItem: UIView, FormItem {
  private(set) var textLabel = UILabel()

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
    setupViews()
    setupAccessibility()
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
    setupViews()
    setupAccessibility()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leftAnchor.constraint(equalTo: leftAnchor),
      textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  private func setupAccessibility() {
    textLabel.accessibilityLabel = textLabel.text
    textLabel.accessibilityTraits = .staticText
  }
}
