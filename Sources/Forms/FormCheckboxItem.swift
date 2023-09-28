import UIKit

/// `FormCheckboxItem` represents a checkbox item in a form. It is a customizable UIView
/// that can be selected or deselected and conforms to the `FormItem` protocol.
open class FormCheckboxItem: UIView, FormItem {
  private let emptyColor: UIColor
  private let filledColor: UIColor
  private let titleLabel = UILabel()
  private let controlView = UIControl()
  private let subtitleLabel = UILabel()
  private let internalStackView = UIStackView()
  private let externalStackView = UIStackView()

  /// The space after the checkbox item in the form.
  public let spacingAfter: CGFloat

  /// Indicates whether the checkbox is selected or not.
  public var isSelected: Bool {
    get { controlView.isSelected }
    set {
      controlView.isSelected = newValue
      controlView.backgroundColor = newValue ? filledColor : emptyColor
    }
  }

  /// A closure that is invoked when the checkbox is tapped.
  public var didSelect: (() -> Void)?

  /// Initializes a new instance of `FormCheckboxItem`.
  /// - Parameters:
  ///   - title: The title of the checkbox item.
  ///   - titleFont: The font of the title label.
  ///   - titleColor: The text color of the title label.
  ///   - subtitle: The subtitle of the checkbox item.
  ///   - subtitleFont: The font of the subtitle label.
  ///   - subtitleColor: The text color of the subtitle label.
  ///   - checkedColor: The background color when the checkbox is selected.
  ///   - uncheckedColor: The background color when the checkbox is not selected.
  ///   - borderWidth: The width of the border of the checkbox.
  ///   - borderColor: The color of the border of the checkbox.
  ///   - cornerRadius: The corner radius of the checkbox.
  ///   - isSelected: The initial state of the checkbox item.
  ///   - spacingAfter: The space after the checkbox item in the form.
  public init(
    title: String,
    titleFont: UIFont = .boldSystemFont(ofSize: 14),
    titleColor: UIColor = .black,
    subtitle: String? = nil,
    subtitleFont: UIFont = .systemFont(ofSize: 12),
    subtitleColor: UIColor = .black,
    checkedColor: UIColor = .green,
    uncheckedColor: UIColor = .white,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .black,
    cornerRadius: CGFloat = 10.0,
    isSelected: Bool = false,
    spacingAfter: CGFloat = 10
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor

    subtitleLabel.text = subtitle
    subtitleLabel.font = subtitleFont
    subtitleLabel.textColor = subtitleColor

    filledColor = checkedColor
    emptyColor = uncheckedColor

    controlView.isSelected = isSelected
    controlView.layer.borderWidth = borderWidth
    controlView.layer.cornerRadius = cornerRadius
    controlView.layer.borderColor = borderColor.cgColor
    controlView.backgroundColor = isSelected ? filledColor : emptyColor

    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupSubviews()

    // Improving accessibility
    titleLabel.accessibilityLabel = title
    titleLabel.accessibilityTraits = .header
    controlView.accessibilityLabel = "Checkbox"
    controlView.accessibilityTraits = .button

    controlView.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
  }

  required public init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    titleLabel.numberOfLines = 0
    subtitleLabel.numberOfLines = 0

    addSubview(externalStackView)
    externalStackView.translatesAutoresizingMaskIntoConstraints = false
    externalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    externalStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    externalStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    externalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    let containerView = UIView()
    containerView.addSubview(controlView)
    controlView.translatesAutoresizingMaskIntoConstraints = false
    controlView.widthAnchor.constraint(equalToConstant: 25).isActive = true
    controlView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    controlView.topAnchor.constraint(equalTo: containerView.topAnchor ,constant: 10).isActive = true
    controlView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    controlView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
    controlView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20).isActive = true

    externalStackView.addArrangedSubview(containerView)
    externalStackView.addArrangedSubview(internalStackView)

    internalStackView.axis = .vertical
    internalStackView.addArrangedSubview(titleLabel)
    internalStackView.addArrangedSubview(subtitleLabel)
    internalStackView.setCustomSpacing(5, after: titleLabel)
  }

  @objc private func didTapCheckbox() {
    isSelected.toggle()
    didSelect?()
  }
}
