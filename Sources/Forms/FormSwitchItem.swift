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
open class FormSwitchItem: UIView, FormInputType {

  /// A structure used to configure a `FormSwitchItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the switch item in the form.
  public struct Configuration {
    let title: String
    let titleAttributes: [NSAttributedString.Key: Any]
    let subtitle: String?
    let subtitleAttributes: [NSAttributedString.Key: Any]?
    let isOn: Bool
    let onColor: UIColor
    let spacingAfter: CGFloat

    /// Initializes a new instance of `FormSwitchItem.Configuration`.
    /// - Parameters:
    ///   - title: The title of the switcher item.
    ///   - titleAttributes: The attributes to apply to the title text.
    ///   - subtitle: The subtitle of the switcher item.
    ///   - subtitleAttributes: The attributes to apply to the subtitle text.
    ///   - isOn: The initial state of the switch item.
    ///   - onColor: The tint color when the switch is toggled on.
    ///   - spacingAfter: The space after the switch item in the form.
    public init(
      title: String,
      titleAttributes: [NSAttributedString.Key: Any],
      subtitle: String?,
      subtitleAttributes: [NSAttributedString.Key: Any]?,
      onColor: UIColor,
      isOn: Bool,
      spacingAfter: CGFloat
    ) {
      self.title = title
      self.titleAttributes = titleAttributes
      self.subtitle = subtitle
      self.subtitleAttributes = subtitleAttributes
      self.isOn = isOn
      self.onColor = onColor
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

  /// The current value in the switcher.
  public var value: Bool {
    switchView.isOn
  }

  /// Initializes a new instance of `FormSwitchItem`.
  /// - Parameters:
  ///   - configuration: The model containing all the attributes of the switch item.
  public init(configuration: Configuration) {
    titleLabel.numberOfLines = 0
    subtitleLabel.numberOfLines = 0
    titleLabel.attributedText = NSAttributedString(
      string: configuration.title,
      attributes: configuration.titleAttributes
    )
    if let subtitle = configuration.subtitle {
      subtitleLabel.attributedText = NSAttributedString(
        string: subtitle,
        attributes: configuration.subtitleAttributes
      )
    }
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
    if #available(iOS 17.0, *) {
      switchView.accessibilityTraits = .toggleButton
    } else {
      switchView.accessibilityTraits = .button
    }
  }

  @objc private func didToggleSwitch() {
    didToggle?(switchView.isOn)
  }
}
