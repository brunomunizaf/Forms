import Combine
import UIKit

/// `FormSwitchItem` represents a switch item in a form.
///
/// This serves as a customizable switch component within a form-based interface,
/// allowing users to toggle between two states—on or off. As a subclass of `UIView`
/// it offers extensive customization options, including adjustments to the title, subtitle
/// and color schemes, enabling the creation of visually cohesive and user-friendly form items.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormSwitchItem: UIView, FormItem {

  /// A structure used to configure a `FormSwitchItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the switch item in the form.
  public struct Configuration {
    let title: String
    let titleFont: UIFont
    let titleColor: UIColor
    let subtitle: String?
    let subtitleFont: UIFont
    let subtitleColor: UIColor
    let onColor: UIColor
    let isOn: Bool
    let spacingAfter: CGFloat

    /// Initializes a new instance of `FormSwitchItem.Configuration`.
    /// - Parameters:
    ///   - title: The title of the switcher item.
    ///   - titleFont: The font of the title label.
    ///   - titleColor: The text color of the title label.
    ///   - subtitle: The subtitle of the switcher item.
    ///   - subtitleFont: The font of the subtitle label.
    ///   - subtitleColor: The text color of the subtitle label.
    ///   - onColor: The tint color when the switch is toggled on.
    ///   - isOn: The initial state of the switch item.
    ///   - spacingAfter: The space after the switch item in the form.
    public init(
      title: String,
      titleFont: UIFont,
      titleColor: UIColor,
      subtitle: String?,
      subtitleFont: UIFont,
      subtitleColor: UIColor,
      onColor: UIColor,
      isOn: Bool,
      spacingAfter: CGFloat
    ) {
      self.title = title
      self.titleFont = titleFont
      self.titleColor = titleColor
      self.subtitle = subtitle
      self.subtitleFont = subtitleFont
      self.subtitleColor = subtitleColor
      self.onColor = onColor
      self.isOn = isOn
      self.spacingAfter = spacingAfter
    }
  }

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
  ///   - configuration: The model containing all the attributes of the switch item.
  public init(configuration: Configuration) {
    titleLabel.text = configuration.title
    titleLabel.numberOfLines = 0
    subtitleLabel.numberOfLines = 0
    titleLabel.font = configuration.titleFont
    titleLabel.textColor = configuration.titleColor
    subtitleLabel.text = configuration.subtitle
    subtitleLabel.font = configuration.subtitleFont
    subtitleLabel.textColor = configuration.subtitleColor
    onColor = configuration.onColor
    switchView.isOn = configuration.isOn
    switchView.onTintColor = configuration.onColor
    spacingAfter = configuration.spacingAfter

    super.init(frame: .zero)

    setupView()
    setupAccessibility()
    switchView.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupView() {
    addSubview(externalStackView)
    externalStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      externalStackView.topAnchor.constraint(equalTo: topAnchor),
      externalStackView.leftAnchor.constraint(equalTo: leftAnchor),
      externalStackView.rightAnchor.constraint(equalTo: rightAnchor),
      externalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    let containerView = UIView()
    containerView.addSubview(switchView)
    switchView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      switchView.widthAnchor.constraint(equalToConstant: 50),
      switchView.heightAnchor.constraint(equalToConstant: 25),
      switchView.topAnchor.constraint(equalTo: containerView.topAnchor ,constant: 10),
      switchView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor),
      switchView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      switchView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20)
    ])

    externalStackView.addArrangedSubview(internalStackView)
    externalStackView.addArrangedSubview(containerView)
    externalStackView.setCustomSpacing(10, after: internalStackView)

    internalStackView.axis = .vertical
    internalStackView.addArrangedSubview(titleLabel)
    internalStackView.addArrangedSubview(subtitleLabel)
    internalStackView.setCustomSpacing(5, after: titleLabel)
  }

  /// Sets up accessibility properties for the control.
  private func setupAccessibility() {
    titleLabel.accessibilityLabel = titleLabel.text
    titleLabel.accessibilityTraits = .header
    switchView.accessibilityLabel = "Switch"
    switchView.accessibilityTraits = .button // N.B: `.toggleButton` is only available on iOS 17
  }

  @objc private func didToggleSwitch() {
    didToggle?(switchView.isOn)
  }
}
