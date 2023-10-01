import Combine
import UIKit

/// `FormInputItem` represents a text input item in a form. 
///
/// It is a customizable text input component within a form-based interface,
/// allowing users to input text or numerical data. As a subclass of `UIView`, it
/// offers extensive customization options
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormInputItem: UIView, FormInputType {
  private let containerView = UIView()
  private let stackView = UIStackView()
  private(set) var titleLabel = UILabel()
  private(set) var textField = UITextField()

  /// An `AnyPublisher` that publishes the `text` from UITextField.
  public var textPublisher: AnyPublisher<String?, Never> {
    textField.editingChanged.eraseToAnyPublisher()
  }

  /// The space after the input item in the form.
  public let spacingAfter: CGFloat

  /// The current text value in the text field.
  public var value: String? {
    textField.text
  }

  /// A closure that is invoked when the text in the text field changes.
  public var didChange: ((String?) -> Void)?

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
    title: String? = nil,
    titleFont: UIFont = .boldSystemFont(ofSize: 14),
    titleColor: UIColor = .black,
    initialText: String? = nil,
    placeholder: String? = nil,
    isSecure: Bool = false,
    autocorrectionType: UITextAutocorrectionType = .default,
    autocapitalizationType: UITextAutocapitalizationType = .sentences,
    font: UIFont = .systemFont(ofSize: 14),
    textColor: UIColor = .black,
    cornerRadius: CGFloat = 10.0,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .clear,
    spacingAfter: CGFloat = 10,
    didChange: ((String?) -> Void)? = nil
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor

    textField.font = font
    textField.text = initialText
    textField.textColor = textColor
    textField.placeholder = placeholder
    textField.isSecureTextEntry = isSecure
    textField.autocorrectionType = autocorrectionType
    textField.autocapitalizationType = autocapitalizationType

    containerView.layer.cornerRadius = cornerRadius
    containerView.layer.borderWidth = borderWidth
    containerView.layer.borderColor = borderColor.cgColor

    self.didChange = didChange
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

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupSubviews() {
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(containerView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leftAnchor.constraint(equalTo: leftAnchor),
      stackView.rightAnchor.constraint(equalTo: rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    containerView.addSubview(textField)
    textField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
      textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
  }

  @objc private func textFieldDidChange() {
    didChange?(textField.text)
  }
}
