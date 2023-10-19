import UIKit

/// `FormCalendarItem` represents a calendar item within a form-based interface.
///
/// This class is a customizable and interactive component, allowing users
/// to pick and represent dates in form-based UIs. As a subclass of `UIView`, it
/// provides extensive customization options.
///
/// - Note: This class conforms to the `FormItem` protocol.
@available(iOS 16.0, *)
open class FormCalendarItem: UIView, FormItem {

  /// A structure used to configure a `FormCalendarItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the calendar item in the form.
  public struct Configuration {
    public struct SelectionSingleDate {
      let delegate: UICalendarSelectionSingleDateDelegate?
      let selectedDate: DateComponents

      /// Initializes a new instance of `FormCalendarItem.Configuration.SelectionSingleDate`.
      /// - Parameters:
      ///   - delegate: .....
      ///   - selectedDate: .....
      public init(
        delegate: UICalendarSelectionSingleDateDelegate?,
        selectedDate: DateComponents
      ) {
        self.delegate = delegate
        self.selectedDate = selectedDate
      }
    }

    public struct SelectionMultiDate {
      let delegate: UICalendarSelectionMultiDateDelegate?
      let selectedDates: [DateComponents]

      /// Initializes a new instance of `FormCalendarItem.Configuration.SelectionMultiDate`.
      /// - Parameters:
      ///   - delegate: .....
      ///   - selectedDates: .....
      public init(
        delegate: UICalendarSelectionMultiDateDelegate?,
        selectedDates: [DateComponents]
      ) {
        self.delegate = delegate
        self.selectedDates = selectedDates
      }
    }

    let title: String
    let calendar: Calendar
    let delegate: UICalendarViewDelegate?
    let tintColor: UIColor
    let spacingAfter: CGFloat
    let availableRange: DateInterval?
    let selectionMultiDate: SelectionMultiDate?
    let selectionSingleDate: SelectionSingleDate?
    let titleAttributes: [NSAttributedString.Key: Any]

    /// Initializes a new instance of `FormCalendarItem.Configuration`.
    /// - Parameters:
    ///   - selectionMultiDate: .....
    ///   - selectionSingleDate: .....
    ///   - calendar: The calendar that the calendar item illustrates
    ///   - spacingAfter: The space after the calendar item in the form.
    public init(
      title: String,
      calendar: Calendar,
      tintColor: UIColor,
      spacingAfter: CGFloat,
      availableRange: DateInterval?,
      delegate: UICalendarViewDelegate?,
      selectionMultiDate: SelectionMultiDate?,
      selectionSingleDate: SelectionSingleDate?,
      titleAttributes: [NSAttributedString.Key : Any]
    ) {
      self.title = title
      self.calendar = calendar
      self.delegate = delegate
      self.tintColor = tintColor
      self.spacingAfter = spacingAfter
      self.availableRange = availableRange
      self.titleAttributes = titleAttributes
      self.selectionMultiDate = selectionMultiDate
      self.selectionSingleDate = selectionSingleDate
    }
  }

  private let titleLabel = UILabel()
  private let stackView = UIStackView()
  private let calendarView = UICalendarView()

  /// The space after the calendar item in the form.
  public var spacingAfter: CGFloat

  public init(configuration: Configuration) {
    spacingAfter = configuration.spacingAfter
    calendarView.delegate = configuration.delegate
    calendarView.calendar = configuration.calendar
    calendarView.tintColor = configuration.tintColor

    titleLabel.numberOfLines = 0
    titleLabel.attributedText = NSAttributedString(
      string: configuration.title,
      attributes: configuration.titleAttributes
    )

    if let availableRange = configuration.availableRange {
      calendarView.availableDateRange = availableRange
    }

    super.init(frame: .zero)

    if let model = configuration.selectionSingleDate {
      let singleDateSelection = UICalendarSelectionSingleDate(delegate: model.delegate)
      singleDateSelection.selectedDate = model.selectedDate
      calendarView.selectionBehavior = singleDateSelection
    }

    if let model = configuration.selectionMultiDate {
      let multiDateSelection = UICalendarSelectionMultiDate(delegate: model.delegate)
      multiDateSelection.selectedDates = model.selectedDates
      calendarView.selectionBehavior = multiDateSelection
    }
    setupViews()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(stackView)
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(calendarView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leftAnchor.constraint(equalTo: leftAnchor),
      stackView.rightAnchor.constraint(equalTo: rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
