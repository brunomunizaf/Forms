import UIKit

public enum FormItemType {
  case text
  case input
  case button
  case spacing
  case checkbox
}

public protocol FormItem: UIView {
  var type: FormItemType { get }
  var spacingAfter: CGFloat { get }
}

public final class FormView: UIView {
  private(set) var elements = [FormItem]()
  private(set) var stackView = UIStackView()

  public init(elements: [FormItem]) {
    self.elements = elements
    super.init(frame: .zero)

    setupStackView()
    elements.forEach {
      stackView.addArrangedSubview($0)
      stackView.setCustomSpacing($0.spacingAfter, after: $0)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupStackView()
  }

  public func add<T>(_ element: T) where T: FormItem {
    elements.append(element)
    stackView.addArrangedSubview(element)
    stackView.setCustomSpacing(element.spacingAfter, after: element)
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
