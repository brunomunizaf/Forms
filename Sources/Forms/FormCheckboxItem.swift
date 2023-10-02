import Combine
import UIKit

/// `FormCheckboxItem` represents a checkbox item within a form-based interface.
///
/// This class is a customizable and interactive component, allowing users
/// to make binary choices in form-based UIs. As a subclass of `UIView`, it
/// provides extensive customization options.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormCheckboxItem: UIView, FormItem {

  /// A structure used to configure a `FormCheckboxItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the checkbox item in the form.
  public struct Configuration {
    let title: String
    let titleFont: UIFont
    let titleColor: UIColor
    let subtitle: String?
    let subtitleFont: UIFont
    let subtitleColor: UIColor
    let checkedColor: UIColor
    let uncheckedColor: UIColor
    let borderWidth: CGFloat
    let borderColor: UIColor
    let cornerRadius: CGFloat
    let isChecked: Bool
    let spacingAfter: CGFloat
    let shouldBeSelected: Bool

    /// Initializes a new instance of `FormCheckboxItem.Configuration`.
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
    ///   - isChecked: The initial state of the checkbox item.
    ///   - spacingAfter: The space after the checkbox item in the form.
    ///   - shouldBeSelected: The initial state of the component item.
    public init(
      title: String,
      titleFont: UIFont,
      titleColor: UIColor,
      subtitle: String?,
      subtitleFont: UIFont,
      subtitleColor: UIColor,
      checkedColor: UIColor,
      uncheckedColor: UIColor,
      borderWidth: CGFloat,
      borderColor: UIColor,
      cornerRadius: CGFloat,
      isChecked: Bool,
      spacingAfter: CGFloat,
      shouldBeSelected: Bool
    ) {
      self.title = title
      self.titleFont = titleFont
      self.titleColor = titleColor
      self.subtitle = subtitle
      self.subtitleFont = subtitleFont
      self.subtitleColor = subtitleColor
      self.checkedColor = checkedColor
      self.uncheckedColor = uncheckedColor
      self.borderWidth = borderWidth
      self.borderColor = borderColor
      self.cornerRadius = cornerRadius
      self.isChecked = isChecked
      self.spacingAfter = spacingAfter
      self.shouldBeSelected = shouldBeSelected
    }
  }

  private let emptyColor: UIColor
  private let filledColor: UIColor
  private let titleLabel = UILabel()
  private let controlView = UIControl()
  private let subtitleLabel = UILabel()
  private let internalStackView = UIStackView()
  private let externalStackView = UIStackView()

  /// An `AnyPublisher` that publishes the `isSelected` state of the component.
  public var isSelectedPublisher: AnyPublisher<Bool, Never> {
    isSelectedSubject.eraseToAnyPublisher()
  }

  /// A subject that receives the state of `isSelected` from the component.
  private let isSelectedSubject: CurrentValueSubject<Bool, Never>

  /// A cancellable object that represents a type-erasing
  /// reference-holding container that stores the produced cancellables.
  private var cancellables: Set<AnyCancellable> = []

  /// The space after the checkbox item in the form.
  public let spacingAfter: CGFloat

  /// Indicates whether the checkbox is selected or not.
  public var isSelected: Bool {
    get { controlView.isSelected }
    set {
      controlView.isSelected = newValue
      isSelectedSubject.send(newValue)
    }
  }

  /// A closure that is invoked when the checkbox is tapped.
  public var didSelect: (() -> Void)?

  /// Initializes a new instance of `FormCheckboxItem`.
  /// - Parameters:
  ///   - configuration: The model containing all the attributes of the checkbox item.
  public init(configuration: Configuration) {
    titleLabel.text = configuration.title
    titleLabel.font = configuration.titleFont
    titleLabel.numberOfLines = 0
    titleLabel.textColor = configuration.titleColor
    subtitleLabel.text = configuration.subtitle
    subtitleLabel.numberOfLines = 0
    subtitleLabel.font = configuration.subtitleFont
    subtitleLabel.textColor = configuration.subtitleColor
    filledColor = configuration.checkedColor
    emptyColor = configuration.uncheckedColor
    controlView.isSelected = configuration.isChecked
    controlView.layer.borderWidth = configuration.borderWidth
    controlView.layer.cornerRadius = configuration.cornerRadius
    controlView.layer.borderColor = configuration.borderColor.cgColor
    controlView.backgroundColor = configuration.isChecked ? filledColor : emptyColor
    isSelectedSubject = CurrentValueSubject<Bool, Never>(configuration.shouldBeSelected)
    spacingAfter = configuration.spacingAfter

    super.init(frame: .zero)

    setupViews()
    setupAccessibility()
    setupObservers()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(externalStackView)
    externalStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      externalStackView.topAnchor.constraint(equalTo: topAnchor),
      externalStackView.leftAnchor.constraint(equalTo: leftAnchor),
      externalStackView.rightAnchor.constraint(equalTo: rightAnchor),
      externalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    let containerView = UIView()
    containerView.addSubview(controlView)
    controlView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      controlView.widthAnchor.constraint(equalToConstant: 25),
      controlView.heightAnchor.constraint(equalToConstant: 25),
      controlView.topAnchor.constraint(equalTo: containerView.topAnchor ,constant: 10),
      controlView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      controlView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      controlView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20)
    ])

    externalStackView.addArrangedSubview(containerView)
    externalStackView.addArrangedSubview(internalStackView)

    internalStackView.axis = .vertical
    internalStackView.addArrangedSubview(titleLabel)
    internalStackView.addArrangedSubview(subtitleLabel)
    internalStackView.setCustomSpacing(5, after: titleLabel)
  }

  private func setupObservers() {
    controlView.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)

    // Observe changes to the isSelectedSubject
    isSelectedSubject.sink { [unowned self] isSelected in
      controlView.backgroundColor = isSelected ? filledColor : emptyColor
    }.store(in: &cancellables)
  }

  /// Sets up accessibility properties for the control.
  private func setupAccessibility() {
    titleLabel.accessibilityLabel = titleLabel.text
    titleLabel.accessibilityTraits = .header
    controlView.accessibilityLabel = "Checkbox"
    controlView.accessibilityTraits = .button
  }

  @objc private func didTapCheckbox() {
    isSelected.toggle()
    didSelect?()
  }
}
