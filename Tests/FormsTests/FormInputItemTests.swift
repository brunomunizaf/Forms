import XCTest
@testable import Forms

final class FormInputItemTests: XCTestCase {
  func testProperInitialization() {
    let title = "Title"
    let placeholder = "Placeholder"
    let initialText = "Initial Text"
    let item = FormInputItem(
      title: title,
      initialText: initialText,
      placeholder: placeholder,
      spacingAfter: 20
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

  func _testDidChangeCallback() {
    let expectation = self.expectation(description: "didChange should be called")
    let item = FormInputItem()

    item.didChange = {
      expectation.fulfill()
    }

    item.textField.text = "New Text"
    item.textField.sendActions(for: .editingChanged)
    waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testConstraintsAreActive() {
    let item = FormInputItem()
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
