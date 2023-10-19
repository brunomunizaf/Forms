import XCTest
@testable import Forms

@available(iOS 16.0, *)
final class FormCalendarItemTests: XCTestCase {
  func testProperInitialization() {
    let configuration = FormCalendarItem.Configuration(
      title: "mock_title",
      calendar: .init(identifier: .chinese),
      tintColor: .red,
      spacingAfter: 12,
      availableRange: .none,
      delegate: nil,
      selectionMultiDate: nil,
      selectionSingleDate: nil,
      titleAttributes: [:]
    )
    let calendarItem = FormCalendarItem(configuration: configuration)

    XCTAssertEqual(calendarItem.spacingAfter, 12)
    XCTAssertNil(calendarItem.calendarView.delegate)
    XCTAssertEqual(calendarItem.titleLabel.numberOfLines, 0)
    XCTAssertNil(calendarItem.calendarView.selectionBehavior)
    XCTAssertEqual(calendarItem.calendarView.tintColor, .red)
    XCTAssertEqual(
      calendarItem.calendarView.calendar,
      Calendar(identifier: .chinese)
    )
    XCTAssertEqual(
      calendarItem.calendarView.availableDateRange,
      .init(start: .distantPast, end: .distantFuture)
    )
    XCTAssertEqual(
      calendarItem.titleLabel.attributedText,
      NSAttributedString(
        string: "mock_title",
        attributes: [:]
      )
    )
  }

  func testSelectionSingleDateDelegate() {
    let singleDelegate = MockSelectionSingleDateDelegate()
    let calendarItem = FormCalendarItem(configuration: .init(
      title: "",
      calendar: .current,
      tintColor: .blue,
      spacingAfter: 0,
      availableRange: nil,
      delegate: nil,
      selectionMultiDate: nil,
      selectionSingleDate: .init(
        delegate: singleDelegate,
        selectedDate: DateComponents(
          year: 2023,
          month: 10,
          day: 19
        )
      ),
      titleAttributes: [:]
    ))

    singleDelegate.dateSelection(
      UICalendarSelectionSingleDate(delegate: nil),
      didSelectDate: DateComponents(
        year: 2023,
        month: 10,
        day: 22
      )
    )

    XCTAssertTrue(singleDelegate.didSelectDateCalled)
    XCTAssertEqual(singleDelegate.selectedDate, DateComponents(
      year: 2023,
      month: 10,
      day: 22
    ))
  }

  func testInitializationUsingNSCoder() {
    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
    let item = FormCalendarItem(coder: archiver)
    XCTAssertNil(item, "Initialization using NSCoder should return nil")
  }
}

@available(iOS 16.0, *)
final class MockSelectionSingleDateDelegate: NSObject, UICalendarSelectionSingleDateDelegate {
  var didSelectDateCalled = false
  var selectedDate: DateComponents?

  func dateSelection(
    _ selection: UICalendarSelectionSingleDate,
    didSelectDate dateComponents: DateComponents?
  ) {
    didSelectDateCalled = true
    selectedDate = dateComponents
  }
}
