import Forms
import UIKit

/// `FinishedScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Finished UI flow.
///
final class FinishedScreenView: UIView {
  // MARK: - Properties

  let formView = FormView(elements: [
    FormTextItem(configuration: .title)
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

// MARK: - FormItem.Configuration

private extension FormTextItem.Configuration {
  static let title = FormTextItem.Configuration(
    text: "Horray! You finished the onboarding. 🎉",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 30)!,
      .foregroundColor: UIColor.label,
      .kern: 0.5,
    ],
    spacingAfter: 20
  )
}
