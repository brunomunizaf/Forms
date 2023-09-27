import UIKit

public final class FormView: UIView {
  private(set) var elements = [FormItem]()
  private(set) var stackView = UIStackView()

  public var isValid: Bool {
    elements
      .compactMap { $0 as? Validatable }
      .allSatisfy { $0.isValid }
  }

  public init(elements: [FormItem]) {
    self.elements = elements
    super.init(frame: .zero)

    setupStackView()
    elements.forEach {
      stackView.addArrangedSubview($0)
      stackView.setCustomSpacing($0.spacingAfter, after: $0)
    }

    setContentCompressionResistancePriority(.required, for: .vertical)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupStackView()
  }

  public func add<T>(_ item: T) where T: FormItem {
    elements.append(item)
    stackView.addArrangedSubview(item)
    stackView.setCustomSpacing(item.spacingAfter, after: item)
  }

  private func setupStackView() {
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }
}
