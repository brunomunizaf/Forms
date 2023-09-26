import UIKit

public final class FormCheckboxItem: UIView, FormItem {
  public var type: FormItemType { .checkbox }

  private(set) var emptyColor: UIColor
  private(set) var filledColor: UIColor
  private(set) var titleLabel = UILabel()
  private(set) var controlView = UIControl()
  private(set) var subtitleLabel = UILabel()
  private(set) var internalStackView = UIStackView()
  private(set) var externalStackView = UIStackView()

  public var spacingAfter: CGFloat

  public var isSelected: Bool {
    get { controlView.isSelected }
    set {
      controlView.isSelected = newValue
      controlView.backgroundColor = newValue ? filledColor : emptyColor
    }
  }

  public var didSelect: (() -> Void)? 

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

    controlView.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
  }

  required init?(coder: NSCoder) { nil }

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
