import Combine
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
  ///   - shouldBeSelected: The initial state of the component item.
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
    spacingAfter: CGFloat = 10,
    shouldBeSelected: Bool = false
  ) {
    titleLabel.text = title
    titleLabel.font = titleFont
    titleLabel.numberOfLines = 0
    titleLabel.textColor = titleColor
    subtitleLabel.text = subtitle
    subtitleLabel.numberOfLines = 0
    subtitleLabel.font = subtitleFont
    subtitleLabel.textColor = subtitleColor
    filledColor = checkedColor
    emptyColor = uncheckedColor
    controlView.isSelected = isSelected
    controlView.layer.borderWidth = borderWidth
    controlView.layer.cornerRadius = cornerRadius
    controlView.layer.borderColor = borderColor.cgColor
    controlView.backgroundColor = isSelected ? filledColor : emptyColor
    isSelectedSubject = CurrentValueSubject<Bool, Never>(shouldBeSelected)

    self.spacingAfter = spacingAfter

    super.init(frame: .zero)
    setupViews()
    setupAccessibility()

    controlView.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)

    // Observe changes to the isSelectedSubject
    isSelectedSubject.sink { [unowned self] isSelected in
      controlView.backgroundColor = isSelected ? filledColor : emptyColor
    }.store(in: &cancellables)
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
