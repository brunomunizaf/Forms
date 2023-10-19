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
    FormTextItem(configuration: .title),
    FormTextItem(configuration: .subtitle),
    requiredInputItem,
    numbersInputItem,
    inputItem,
    calendarItem,
    FormSpacingItem(),
    buttonItem
  ])

  let scrollView = UIScrollView()
  let inputItem = FormInputItem(configuration: .first)
  let requiredInputItem = MinimumFormInputItem(configuration: .second)
  let numbersInputItem = RegexFormInputItem(configuration: .third)
  let buttonItem = FormButtonItem(configuration: .personal)
  lazy var calendarItem = FormCalendarItem(configuration: .personal(delegate: self))

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

// MARK: - FormItem.Configuration

private extension FormTextItem.Configuration {
  static let title = FormTextItem.Configuration(
    text: "Your personal details",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
      .foregroundColor: UIColor.label,
      .kern: 0.5
    ],
    spacingAfter: 20
  )

  static let subtitle = FormTextItem.Configuration(
    text: "Insert your personal information to keep your profile up to date.",
    attributes: [
      .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
      .foregroundColor: UIColor.secondaryLabel,
      .kern: 0.2
    ],
    spacingAfter: 20
  )
}

private extension FormInputItem.Configuration {
  static let first = FormInputItem.Configuration(
    title: "Street Address",
    titleAttributes: [
      .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
      .foregroundColor: UIColor.label
    ],
    initialText: nil,
    placeholder: "e.g. 5912 5th Avenue, New York, NY",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.label,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.systemGray,
    spacingAfter: 15,
    didChange: nil
  )

  static let second = FormInputItem.Configuration(
    title: "Full Name",
    titleAttributes: [
      .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
      .foregroundColor: UIColor.label
    ],
    initialText: nil,
    placeholder: "Required",
    isSecure: false,
    autocorrectionType: .default,
    autocapitalizationType: .words,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.label,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    spacingAfter: 15,
    didChange: nil
  )

  static let third = FormInputItem.Configuration(
    title: "Phone Number",
    titleAttributes: [
      .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
      .foregroundColor: UIColor.label
    ],
    initialText: nil,
    placeholder: "Only numbers allowed",
    isSecure: false,
    autocorrectionType: .no,
    autocapitalizationType: .none,
    font: UIFont(name: "AvenirNext-Regular", size: 16)!,
    textColor: UIColor.label,
    cornerRadius: 8,
    borderWidth: 1.0,
    borderColor: UIColor.lightGray,
    spacingAfter: 15,
    didChange: nil
  )
}

private extension FormButtonItem.Configuration {
  static let personal = FormButtonItem.Configuration(
    title: "Continue to Permissions",
    attributes: [
      .font: UIFont(name: "AvenirNext-DemiBold", size: 18)!,
      .foregroundColor: UIColor.white
    ],
    enabledColor: .systemBlue,
    disabledColor: .systemGray3,
    borderWidth: 1.5,
    borderColor: .systemBlue,
    cornerRadius: 20.0,
    spacingAfter: 20,
    shouldBeEnabled: false
  )
}

private extension FormCalendarItem.Configuration {
  static func personal(
    delegate: CalendarDelegate
  ) -> FormCalendarItem.Configuration {
    FormCalendarItem.Configuration(
      title: "Date of Birth",
      calendar: .init(identifier: .gregorian),
      tintColor: .label,
      spacingAfter: 20,
      availableRange: DateInterval(start: .distantPast, end: .now),
      delegate: delegate,
      selectionMultiDate: nil,
      selectionSingleDate: .selectionSingleDate(delegate: delegate),
      titleAttributes: [
        .font: UIFont(name: "AvenirNext-Medium", size: 16)!,
        .foregroundColor: UIColor.label
      ]
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
