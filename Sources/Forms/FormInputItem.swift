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

  /// A structure used to configure a `FormInputItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the input item in the form.
  public struct Configuration {
    let title: String?
    let titleFont: UIFont
    let titleColor: UIColor
    let initialText: String?
    let placeholder: String?
    let isSecure: Bool
    let autocorrectionType: UITextAutocorrectionType
    let autocapitalizationType: UITextAutocapitalizationType
    let font: UIFont
    let textColor: UIColor
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: UIColor
    let spacingAfter: CGFloat
    let didChange: ((String?) -> Void)?

    /// Initializes a new instance of `FormInputItem.Configuration`.
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
      title: String?, 
      titleFont: UIFont,
      titleColor: UIColor,
      initialText: String?,
      placeholder: String?,
      isSecure: Bool,
      autocorrectionType: UITextAutocorrectionType,
      autocapitalizationType: UITextAutocapitalizationType,
      font: UIFont,
      textColor: UIColor,
      cornerRadius: CGFloat,
      borderWidth: CGFloat,
      borderColor: UIColor,
      spacingAfter: CGFloat,
      didChange: ((String?) -> Void)?
    ) {
      self.title = title
      self.titleFont = titleFont
      self.titleColor = titleColor
      self.initialText = initialText
      self.placeholder = placeholder
      self.isSecure = isSecure
      self.autocorrectionType = autocorrectionType
      self.autocapitalizationType = autocapitalizationType
      self.font = font
      self.textColor = textColor
      self.cornerRadius = cornerRadius
      self.borderWidth = borderWidth
      self.borderColor = borderColor
      self.spacingAfter = spacingAfter
      self.didChange = didChange
    }
  }

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
  ///   - configuration: The model containing all the attributes of the input item.
  public init(configuration: Configuration) {
    titleLabel.text = configuration.title
    titleLabel.font = configuration.titleFont
    titleLabel.textColor = configuration.titleColor
    textField.font = configuration.font
    textField.text = configuration.initialText
    textField.textColor = configuration.textColor
    textField.placeholder = configuration.placeholder
    textField.isSecureTextEntry = configuration.isSecure
    textField.autocorrectionType = configuration.autocorrectionType
    textField.autocapitalizationType = configuration.autocapitalizationType
    containerView.layer.cornerRadius = configuration.cornerRadius
    containerView.layer.borderWidth = configuration.borderWidth
    containerView.layer.borderColor = configuration.borderColor.cgColor
    didChange = configuration.didChange
    spacingAfter = configuration.spacingAfter

    super.init(frame: .zero)
    
    setupViews()
    setupAccessibility()
    textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
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

  private func setupAccessibility() {
    titleLabel.accessibilityLabel = titleLabel.text
    titleLabel.accessibilityTraits = .header
    textField.accessibilityLabel = "Input field"
    textField.accessibilityTraits = .none
  }

  @objc private func textFieldDidChange() {
    didChange?(textField.text)
  }
}
