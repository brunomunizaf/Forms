import XCTest
@testable import Forms

final class FormInputItemTests: XCTestCase {
  func testProperInitialization() {
    let title = "Title"
    let placeholder = "Placeholder"
    let initialText = "Initial Text"
    let item = FormInputItem(
      configuration: .init(
        title: title,
        titleAttributes: [:],
        initialText: initialText,
        placeholder: placeholder,
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

  func testConstraintsAreActive() {
    let item = FormInputItem(
      configuration: .init(
        title: nil,
        titleAttributes: [:],
        initialText: nil,
        placeholder: nil,
        isSecure: false,
        autocorrectionType: .default,
        autocapitalizationType: .allCharacters,
        font: .boldSystemFont(ofSize: 1),
        textColor: .black,
        cornerRadius: 1,
        borderWidth: 1,
        borderColor: .black,
        spacingAfter: 1,
        didChange: nil
      )
    )
    item.layoutIfNeeded() // Force layout so constraints are activated.

    for constraint in item.constraints {
      XCTAssertTrue(constraint.isActive, "All constraints should be active")
    }
  }

  func testInitializationUsingNSCoder() {
    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
    let item = FormInputItem(coder: archiver)
    XCTAssertNil(item, "Initialization using NSCoder should return nil")
  }
}
