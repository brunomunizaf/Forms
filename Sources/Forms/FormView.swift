import UIKit

/// A `UIView` subclass representing a form containing multiple `FormItem`s arranged vertically.
open class FormView: UIView {
  /// An array holding the `FormItem`s.
  private var elements = [FormItem]()

  /// A `UIStackView` to manage the layout of `FormItem`s.
  private(set) var stackView = UIStackView()

  /// A Boolean value indicating whether all validatable `FormItem`s are valid.
  public var isValid: Bool {
    elements
      .compactMap { $0 as? (any Validatable) }
      .allSatisfy { $0.isValid }
  }

  /// Initializes a new `FormView` with the given `FormItem`s.
  /// - Parameter elements: An array of `FormItem`s to be added to the form.
  public init(elements: [FormItem]) {
    self.elements = elements
    super.init(frame: .zero)

    setupStackView()
    elements.forEach {
      stackView.addArrangedSubview($0)
      stackView.setCustomSpacing($0.spacingAfter, after: $0)
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupStackView()
  }

  /// Adds a new `FormItem` to the `FormView`.
  /// - Parameter item: The `FormItem` to be added.
  public func add<T>(_ item: T) where T: FormItem {
    elements.append(item)
    stackView.addArrangedSubview(item)
    stackView.setCustomSpacing(item.spacingAfter, after: item)
  }

  /// Configures the `UIStackView` and adds it to the `FormView`.
  private func setupStackView() {
    stackView.axis = .vertical
    addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leftAnchor.constraint(equalTo: leftAnchor),
      stackView.rightAnchor.constraint(equalTo: rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
