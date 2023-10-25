import Forms
import UIKit

/// `TermsScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Terms and Conditions UI flow.
///
final class TermsScreenView: UIView {
  // MARK: - Properties

  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .h1(Strings.Terms.title)),
    FormTextItem(configuration: .h2(Strings.Terms.subtitle)),
    FormSpacingItem(),
    checkboxItem,
    buttonItem
  ])

  let checkboxItem = RequiredFormCheckboxItem(
    configuration: .with(
      title: Strings.Terms.checkboxTitle,
      subtitle: Strings.Terms.checkboxSubtitle,
      highlightedSubtitle: Strings.Terms.checkboxSubtitleHighlighted
    )
  )
  let buttonItem = FormButtonItem(
    configuration: .withTitle(Strings.Terms.button)
  )

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
