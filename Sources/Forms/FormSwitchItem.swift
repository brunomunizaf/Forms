import Combine
import UIKit

/// `FormSwitchItem` represents a switch item in a form. It is a customizable UIView
/// that can be toggled on or off, and conforms to the `FormItem` protocol.
open class FormSwitchItem: UIView, FormItem {
  private let onColor: UIColor
  private let titleLabel = UILabel()
  private let switchView = UISwitch()
  private let subtitleLabel = UILabel()
  private let internalStackView = UIStackView()
  private let externalStackView = UIStackView()

  /// An `AnyPublisher` that publishes the `isOn` state of the switch.
  public var isOnPublisher: AnyPublisher<Bool, Never> {
    switchView
      .valueChangedPublisher
      .map { [unowned self] in switchView.isOn }
      .eraseToAnyPublisher()
  }

  /// The space after the switch item in the form.
  public let spacingAfter: CGFloat

  /// A closure that is invoked when the switch is toggled.
  public var didToggle: ((Bool) -> Void)?

  /// Initializes a new instance of `FormSwitchItem`.
  /// - Parameters:
  ///   - title: The title of the switch item.
  ///   - titleFont: The font of the title label.
  ///   - titleColor: The text color of the title label.
  ///   - subtitle: The subtitle of the switch item.
  ///   - subtitleFont: The font of the subtitle label.
  ///   - subtitleColor: The text color of the subtitle label.
  ///   - onColor: The background color when the switch is on.
  ///   - isOn: The initial state of the switch item.
  ///   - spacingAfter: The space after the switch item in the form.
  public init(
    title: String,
    titleFont: UIFont = .boldSystemFont(ofSize: 14),
    titleColor: UIColor = .black,
    subtitle: String? = nil,
    subtitleFont: UIFont = .systemFont(ofSize: 12),
    subtitleColor: UIColor = .black,
    onColor: UIColor = .systemOrange,
    isOn: Bool = false,
    spacingAfter: CGFloat = 10
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor

    subtitleLabel.text = subtitle
    subtitleLabel.font = subtitleFont
    subtitleLabel.textColor = subtitleColor

    self.onColor = onColor
    switchView.isOn = isOn
    switchView.onTintColor = onColor

    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupSubviews()

    // Improving accessibility
    titleLabel.accessibilityLabel = title
    titleLabel.accessibilityTraits = .header
    switchView.accessibilityLabel = "Switch"
    switchView.accessibilityTraits = .button // N.B: `.toggleButton` is only available on iOS 17

    switchView.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
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
    containerView.addSubview(switchView)
    switchView.translatesAutoresizingMaskIntoConstraints = false
    switchView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    switchView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    switchView.topAnchor.constraint(equalTo: containerView.topAnchor ,constant: 10).isActive = true
    switchView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor).isActive = true
    switchView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
    switchView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20).isActive = true

    externalStackView.addArrangedSubview(internalStackView)
    externalStackView.addArrangedSubview(containerView)
    externalStackView.setCustomSpacing(10, after: internalStackView)

    internalStackView.axis = .vertical
    internalStackView.addArrangedSubview(titleLabel)
    internalStackView.addArrangedSubview(subtitleLabel)
    internalStackView.setCustomSpacing(5, after: titleLabel)
  }

  @objc private func didToggleSwitch() {
    didToggle?(switchView.isOn)
  }
}
