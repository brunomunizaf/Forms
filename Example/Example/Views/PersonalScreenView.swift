import Forms
import UIKit

typealias CalendarDelegate =
UICalendarViewDelegate &
UICalendarSelectionMultiDateDelegate &
UICalendarSelectionSingleDateDelegate

/// `PersonalScreenView` is a `UIView` subclass that sets up and
/// manages `FormItem's` included on the Personal Details UI flow.
///
final class PersonalScreenView: UIView {
  // MARK: - Properties

  lazy var formView = FormView(elements: [
    FormTextItem(configuration: .h1(Strings.Personal.title)),
    FormTextItem(configuration: .h2(Strings.Personal.subtitle)),
    nameItem,
    phoneItem,
    addressItem,
    calendarItem,
    FormSpacingItem(),
    buttonItem
  ])

  let scrollView = UIScrollView()
  let addressItem = FormInputItem(configuration: .with(
    title: Strings.Personal.addressTitle,
    placeholder: Strings.Personal.addressPlaceholder
  ))
  let nameItem = MinimumFormInputItem(configuration: .with(
    title: Strings.Personal.nameTitle,
    placeholder: Strings.Personal.namePlaceholder
  ))
  let phoneItem = RegexFormInputItem(configuration: .with(
    title: Strings.Personal.phoneTitle,
    placeholder: Strings.Personal.phonePlaceholder
  ))
  lazy var calendarItem = FormCalendarItem(
    configuration: .personal(delegate: self)
  )
  let buttonItem = FormButtonItem(
    configuration: .withTitle(Strings.Personal.button)
  )

  init() {
    super.init(frame: .zero)
    backgroundColor = .systemBackground

    addSubview(scrollView)
    scrollView.addSubview(formView)
    scrollView.keyboardDismissMode = .interactive
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    formView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      formView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      formView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
      formView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
      formView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
      formView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
    ])
    let heightConstraint = formView.heightAnchor.constraint(
      equalTo: scrollView.heightAnchor, constant: -50
    )
    heightConstraint.priority = .defaultLow
    heightConstraint.isActive = true
  }

  required init?(coder: NSCoder) { nil }
}

// MARK: - UICalendarSelectionSingleDateDelegate

extension PersonalScreenView: UICalendarSelectionSingleDateDelegate {
  func dateSelection(
    _ selection: UICalendarSelectionSingleDate,
    didSelectDate dateComponents: DateComponents?
  ) {
    if let day = dateComponents?.day,
       let month = dateComponents?.month,
       let year = dateComponents?.year {
      print(">>> Did select \(day)/\(month)/\(year)")
    }
  }
}

// MARK: - UICalendarSelectionMultiDateDelegate

extension PersonalScreenView: UICalendarSelectionMultiDateDelegate {
  func multiDateSelection(
    _ selection: UICalendarSelectionMultiDate,
    didSelectDate dateComponents: DateComponents
  ) {
    if let day = dateComponents.day,
       let month = dateComponents.month,
       let year = dateComponents.year {
      print(">>> Did select \(day)/\(month)/\(year)")
    }
  }

  func multiDateSelection(
    _ selection: UICalendarSelectionMultiDate,
    didDeselectDate dateComponents: DateComponents
  ) {
    if let day = dateComponents.day,
       let month = dateComponents.month,
       let year = dateComponents.year {
      print(">>> Did de-select \(day)/\(month)/\(year)")
    }
  }
}

// MARK: - UICalendarViewDelegate

extension PersonalScreenView: UICalendarViewDelegate {
  func calendarView(
    _ calendarView: UICalendarView,
    decorationFor dateComponents: DateComponents
  ) -> UICalendarView.Decoration? {
    switch dateComponents.day {
    case 5:
      return .default(color: .systemRed, size: .small)
    default:
      return .default(color: .systemGreen, size: .small)
    }
  }
}

private extension FormCalendarItem.Configuration {
  static func personal(
    delegate: CalendarDelegate
  ) -> FormCalendarItem.Configuration {
    FormCalendarItem.Configuration(
      title: [
        NSAttributedString(
          string: Strings.Personal.calendarTitle,
          attributes: [
            .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
            .foregroundColor: UIColor.label
          ])
      ],
      calendar: .init(identifier: .gregorian),
      tintColor: .label,
      spacingAfter: 20,
      availableRange: DateInterval(start: .distantPast, end: .now),
      delegate: delegate,
      selectionMultiDate: nil,
      selectionSingleDate: .selectionSingleDate(delegate: delegate)
    )
  }
}

private extension FormCalendarItem.Configuration.SelectionSingleDate {
  static func selectionSingleDate(
    delegate: UICalendarSelectionSingleDateDelegate
  ) -> FormCalendarItem.Configuration.SelectionSingleDate {
    FormCalendarItem.Configuration.SelectionSingleDate(
      delegate: delegate,
      selectedDate: DateComponents(year: 1995, month: 06, day: 01)
    )
  }
}
