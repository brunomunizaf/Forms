import UIKit

/// `FormTextItem` represents a text item in a form.
///
/// As a subclass of `UIView`, it is designed to hold and display text content
/// within form layouts, offering extensive customization options for text attributes
/// and styles.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormTextItem: UIView, FormItem {

  /// A structure used to configure a `FormTextItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the text item in the form.
  public struct Configuration {
    let text: [NSAttributedString]
    let spacingAfter: CGFloat

    /// Initializes a new instance of `FormTextItem.Configuration`.
    /// - Parameters:
    ///   - text: A collection of attributed strings that will compose the item.
    ///   - spacingAfter: The space after the text item in the form.
    public init(
      text: [NSAttributedString],
      spacingAfter: CGFloat
    ) {
      self.text = text
      self.spacingAfter = spacingAfter
    }
  }

  private(set) var textLabel = UILabel()

  /// The space after the text item in the form.
  public let spacingAfter: CGFloat

  /// Initializes a new instance of `FormTextItem` with the provided text attributes.
  /// - Parameters:
  ///   - configuration: The model containing all the attributes of the text item.
  public init(configuration: Configuration) {
    textLabel.numberOfLines = 0
    textLabel.attributedText = configuration.text.reduce(
      into: NSMutableAttributedString()
    ) { $0.append($1) }
    spacingAfter = configuration.spacingAfter

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
  @available(*, deprecated, message: "Use 'init(configuration:)'")
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

  required public init?(coder: NSCoder) { nil }

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
