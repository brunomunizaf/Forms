import Forms
import UIKit

/// `FinishedScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Finished UI flow.
///
final class FinishedScreenView: UIView {
  // MARK: - Properties

  let formView = FormView(elements: [
    FormTextItem(configuration: .h1(Strings.Finished.title))
  ])

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemBackground

    addSubview(formView)
    formView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      formView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      formView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      formView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      formView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
      formView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
    ])
  }

  required init?(coder: NSCoder) { nil }
}
