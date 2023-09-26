import UIKit

public final class FormInputItem: UIView, FormItem {
  public var type: FormItemType { .input }

  private(set) var titleLabel = UILabel()
  private(set) var containerView = UIView()
  private(set) var stackView = UIStackView()
  private(set) var textField = UITextField()

  public var spacingAfter: CGFloat { 10 }

  public init(
    title: String? = nil,
    titleFont: UIFont = .systemFont(ofSize: 12),
    titleColor: UIColor = .black,
    initialText: String? = nil,
    placeholder: String? = nil,
    font: UIFont = .systemFont(ofSize: 12),
    textColor: UIColor = .black,
    cornerRadius: CGFloat = 0.0,
    borderWidth: CGFloat = 0.0,
    borderColor: UIColor = .clear
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor

    if let initialText {
      textField.text = initialText
    }
    if let placeholder {
      textField.placeholder = placeholder
    }
    textField.font = font
    textField.textColor = textColor
    containerView.layer.borderWidth = borderWidth
    containerView.layer.cornerRadius = cornerRadius
    containerView.layer.borderColor = borderColor.cgColor

    super.init(frame: .zero)
    setupSubviews()
  }

  required init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    titleLabel.numberOfLines = 0

    stackView.spacing = 8
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(containerView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    containerView.addSubview(textField)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
    textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
    textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
    textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
  }
}
