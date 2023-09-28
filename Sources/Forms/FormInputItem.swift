import UIKit

/// `FormInputItem` represents a text input item in a form. It is a customizable UIView
/// with a title and a text field and conforms to the `FormInputType` protocol.
open class FormInputItem: UIView, FormInputType {
  private let titleLabel = UILabel()
  private let containerView = UIView()
  private let stackView = UIStackView()
  private let textField = UITextField()

  /// The space after the input item in the form.
  public let spacingAfter: CGFloat

  /// The current text value in the text field.
  public var value: String? {
    textField.text
  }

  /// A closure that is invoked when the text in the text field changes.
  public var didChange: (() -> Void)?

  /// Initializes a new instance of `FormInputItem`.
  /// - Parameters:
  ///   - title: The title of the input item.
  ///   - titleFont: The font of the title label.
  ///   - titleColor: The text color of the title label.
  ///   - initialText: The initial text in the text field.
  ///   - placeholder: The placeholder text in the text field.
  ///   - font: The font of the text field.
  ///   - textColor: The text color of the text field.
  ///   - cornerRadius: The corner radius of the container view.
  ///   - borderWidth: The width of the border of the container view.
  ///   - borderColor: The color of the border of the container view.
  ///   - spacingAfter: The space after the input item in the form.
  public init(
    title: String,
    titleFont: UIFont = .boldSystemFont(ofSize: 14),
    titleColor: UIColor = .black,
    initialText: String? = nil,
    placeholder: String? = nil,
    font: UIFont = .systemFont(ofSize: 14),
    textColor: UIColor = .black,
    cornerRadius: CGFloat = 10.0,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .clear,
    spacingAfter: CGFloat = 10
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor

    textField.text = initialText
    textField.placeholder = placeholder
    textField.font = font
    textField.textColor = textColor

    containerView.layer.cornerRadius = cornerRadius
    containerView.layer.borderWidth = borderWidth
    containerView.layer.borderColor = borderColor.cgColor

    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupSubviews()

    // Improving accessibility
    titleLabel.accessibilityLabel = title
    titleLabel.accessibilityTraits = .header
    textField.accessibilityLabel = "Input field"
    textField.accessibilityTraits = .none

    textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }

  required public init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(containerView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    containerView.addSubview(textField)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
    textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
    textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
    textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
  }

  @objc private func textFieldDidChange() {
    didChange?()
  }
}
