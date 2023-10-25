import Combine
import UIKit

/// `FormButtonItem` represents a button item in a form. 
///
/// This class is a customizable UIControl that can be used to represent buttons
/// in form-based UIs. It allows customization of various visual attributes and
/// can be enabled or disabled, changing its appearance based on its state.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormButtonItem: UIControl, FormItem {

  /// A structure used to configure a `FormButtonItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the button in the form.
  public struct Configuration {
    let title: [NSAttributedString]
    let enabledColor: UIColor
    let disabledColor: UIColor
    let borderWidth: CGFloat
    let borderColor: UIColor
    let cornerRadius: CGFloat
    let spacingAfter: CGFloat
    let shouldBeEnabled: Bool

    /// Initializes a new instance of `FormButtonItem.Configuration`.
    /// - Parameters:
    ///   - title: A collection of attributed strings that will compose the title of the button item.
    ///   - attributes: A dictionary with the attributes for the title label.
    ///   - enabledColor: The background color when the button is enabled.
    ///   - disabledColor: The background color when the button is disabled.
    ///   - borderWidth: The width of the border of the button.
    ///   - borderColor: The color of the border of the button.
    ///   - cornerRadius: The corner radius of the button.
    ///   - spacingAfter: The space after the button item in the form.
    ///   - shouldBeEnabled: The initial state of the button item.
    public init(
      title: [NSAttributedString],
      enabledColor: UIColor,
      disabledColor: UIColor,
      borderWidth: CGFloat,
      borderColor: UIColor,
      cornerRadius: CGFloat,
      spacingAfter: CGFloat,
      shouldBeEnabled: Bool
    ) {
      self.title = title
      self.enabledColor = enabledColor
      self.disabledColor = disabledColor
      self.borderWidth = borderWidth
      self.borderColor = borderColor
      self.cornerRadius = cornerRadius
      self.spacingAfter = spacingAfter
      self.shouldBeEnabled = shouldBeEnabled
    }
  }

  private let titleLabel = UILabel()
  private let enabledColor: UIColor
  private let disabledColor: UIColor

  /// The space after the button item in the form.
  public let spacingAfter: CGFloat

  /// Indicates whether the button item is enabled or disabled.
  open override var isEnabled: Bool {
    get { super.isEnabled }
    set {
      super.isEnabled = newValue
      isEnabledSubject.send(newValue)
    }
  }

  /// An `AnyPublisher` that publishes the `isEnabled` state of the button.
  public var isEnabledPublisher: AnyPublisher<Bool, Never> {
    isEnabledSubject.eraseToAnyPublisher()
  }

  /// A subject that receives the state of `isEnabled` from the button.
  private let isEnabledSubject: CurrentValueSubject<Bool, Never>

  /// A cancellable object that represents a type-erasing
  /// reference-holding container that stores the produced cancellables.
  private var cancellables: Set<AnyCancellable> = []

  /// Initializes a new instance of `FormButtonItem`.
  /// - Parameters:
  ///   - configuration: The model containing all the attributes of the button item.
  public init(configuration: Configuration) {
    titleLabel.numberOfLines = 0
    titleLabel.attributedText = configuration.title.reduce(
      into: NSMutableAttributedString()
    ) { $0.append($1) }
    spacingAfter = configuration.spacingAfter
    enabledColor = configuration.enabledColor
    disabledColor = configuration.disabledColor
    isEnabledSubject = CurrentValueSubject<Bool, Never>(configuration.shouldBeEnabled)

    super.init(frame: .zero)
    isEnabled = configuration.shouldBeEnabled

    layer.borderWidth = configuration.borderWidth
    layer.cornerRadius = configuration.cornerRadius
    layer.borderColor = configuration.borderColor.cgColor

    setupView()
    setupAccessibility()
    observeIsEnabled()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets up the view by adding `titleLabel` as a subview and activating its layout constraints.
  private func setupView() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 10),
      titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }

  /// Sets up accessibility properties for the control.
  private func setupAccessibility() {
    titleLabel.accessibilityLabel = titleLabel.text
    titleLabel.accessibilityTraits = .header
    titleLabel.accessibilityHint = "Tap to activate"
  }

  // Observe changes to the isEnabledSubject
  private func observeIsEnabled() {
    isEnabledSubject.sink { [unowned self] isEnabled in
      backgroundColor = isEnabled ? enabledColor : disabledColor
    }.store(in: &cancellables)
  }
}
