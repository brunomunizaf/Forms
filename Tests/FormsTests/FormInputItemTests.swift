import XCTest
@testable import Forms

final class FormInputItemTests: XCTestCase {
  func testProperInitialization() {
    let title = "Title"
    let placeholder = "Placeholder"
    let initialText = "Initial Text"
    let item = FormInputItem(
      configuration: .init(
        title: [NSAttributedString(string: title)],
        initialText: initialText,
        placeholder: [NSAttributedString(string: placeholder)],
        isSecure: false,
        autocorrectionType: .no,
        autocapitalizationType: .none,
        font: .boldSystemFont(ofSize: 10),
        textColor: .blue,
        cornerRadius: 10,
        borderWidth: 2.0,
        borderColor: .black,
        spacingAfter: 20,
        didChange: nil
      )
    )

    XCTAssertEqual(
      item.titleLabel.text, title,
      "Title should be initialized correctly"
    )
    XCTAssertEqual(
      item.textField.placeholder, placeholder,
      "Placeholder should be initialized correctly"
    )
    XCTAssertEqual(
      item.textField.text, initialText,
      "Initial text should be initialized correctly"
    )
    XCTAssertEqual(
      item.spacingAfter, 20,
      "spacingAfter should be initialized correctly"
    )
  }

  func testInitializationUsingNSCoder() {
    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
    let item = FormInputItem(coder: archiver)
    XCTAssertNil(item, "Initialization using NSCoder should return nil")
  }
}
