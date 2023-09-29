import Combine
import UIKit

/// `FormButtonItem` represents a button item in a form. It is a customizable UIControl
/// with a title and conforms to the `FormItem` protocol. It can be enabled or disabled,
/// changing its background color accordingly.
open class FormButtonItem: UIControl, FormItem {
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
  ///   - title: The title of the button item.
  ///   - font: The font of the title label.
  ///   - textColor: The text color of the title label.
  ///   - enabledColor: The background color when the button is enabled.
  ///   - disabledColor: The background color when the button is disabled.
  ///   - borderWidth: The width of the border of the button.
  ///   - borderColor: The color of the border of the button.
  ///   - cornerRadius: The corner radius of the button.
  ///   - spacingAfter: The space after the button item in the form.
  ///   - shouldBeEnabled: The initial state of the button item.
  public init(
    title: String,
    font: UIFont = .boldSystemFont(ofSize: 14),
    textColor: UIColor = .black,
    enabledColor: UIColor = .green,
    disabledColor: UIColor = .white,
    borderWidth: CGFloat = 1.5,
    borderColor: UIColor = .clear,
    cornerRadius: CGFloat = 10.0,
    spacingAfter: CGFloat = 0,
    shouldBeEnabled: Bool = true
  ) {
    self.titleLabel.font = font
    self.titleLabel.text = title
    self.titleLabel.textColor = textColor
    self.spacingAfter = spacingAfter
    self.enabledColor = enabledColor
    self.disabledColor = disabledColor
    self.isEnabledSubject = CurrentValueSubject<Bool, Never>(shouldBeEnabled)

    super.init(frame: .zero)
    self.isEnabled = shouldBeEnabled

    layer.borderWidth = borderWidth
    layer.cornerRadius = cornerRadius
    layer.borderColor = borderColor.cgColor

    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 10).isActive = true
    titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -10).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true

    // Observe changes to the isEnabledSubject
    isEnabledSubject.sink { [unowned self] isEnabled in
      backgroundColor = isEnabled ? enabledColor : disabledColor
    }.store(in: &cancellables)

    // Improving accessibility
    titleLabel.accessibilityLabel = title
    titleLabel.accessibilityTraits = .header
  }

  required public init?(coder: NSCoder) { nil }
}
