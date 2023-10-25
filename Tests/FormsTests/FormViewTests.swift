import XCTest
@testable import Forms

final class FormViewTests: XCTestCase {
  func testFormViewInitWithValidItems() {
    let formItems = [FormItemMock(), FormItemMock()]
    let formView = FormView(elements: formItems)
    XCTAssertTrue(
      formView.isValid,
      "FormView should be valid when initialized with all valid items"
    )
  }

  func testFormViewInitWithInvalidItems() {
    let formItems = [FormItemMock(isValid: false), FormItemMock()]
    let formView = FormView(elements: formItems)
    XCTAssertFalse(
      formView.isValid,
      "FormView should be invalid when initialized with any invalid item"
    )
  }

  func testAddValidItem() {
    let formView = FormView(elements: [])
    let newItem = FormItemMock()
    formView.add(newItem)
    XCTAssertTrue(
      formView.isValid,
      "FormView should be valid when a valid item is added"
    )
  }

  func testAddInvalidItem() {
    let formView = FormView(elements: [])
    let newItem = FormItemMock(isValid: false)
    formView.add(newItem)
    XCTAssertFalse(
      formView.isValid,
      "FormView should be invalid when an invalid item is added"
    )
  }

  func testFormViewWithStackView() {
    let formItems = [FormItemMock(), FormItemMock()]
    let formView = FormView(elements: formItems)
    XCTAssertEqual(
      formView.stackView.arrangedSubviews.count, formItems.count,
      "FormView's stackView should have the same number of arranged subviews as form items"
    )
  }

  func testStackViewInitialSetup() {
    let formView = FormView(elements: [])
    XCTAssertEqual(
      formView.stackView.axis, .vertical,
      "stackView axis should be vertical"
    )
    XCTAssertFalse(
      formView.stackView.translatesAutoresizingMaskIntoConstraints,
      "stackView should not use autoresizing mask"
    )
  }

  func testElementInteractionAfterInitialization() {
    let formView = FormView(elements: [FormItemMock()])
    let newItem = FormItemMock()
    formView.add(newItem)

    XCTAssertEqual(
      formView.stackView.arrangedSubviews.count, 2,
      "stackView should have two items after adding one"
    )
    XCTAssertTrue(
      formView.stackView.arrangedSubviews.contains(newItem),
      "stackView should contain the newly added item"
    )
  }

  func testUIWithMultipleElements() {
    let formItems = [FormItemMock(), FormItemMock(), FormItemMock()]
    let formView = FormView(elements: formItems)

    XCTAssertEqual(
      formView.stackView.arrangedSubviews.count, formItems.count,
      "stackView should have the same number of items as initialized"
    )
  }

  func testUIWithZeroElements() {
    let formView = FormView(elements: [])
    XCTAssertEqual(
      formView.stackView.arrangedSubviews.count, 0,
      "stackView should have zero items when initialized with zero elements"
    )
  }

  func testAddingLargeNumberOfElements() {
    let formView = FormView(elements: [])
    for _ in 0..<1000 {
      let newItem = FormItemMock()
      formView.add(newItem)
    }

    XCTAssertEqual(
      formView.stackView.arrangedSubviews.count, 1000,
      "stackView should be able to handle a large number of elements"
    )
  }
}

private final class FormItemMock: UIView, FormItem, Validatable {
  var value: String { fatalError() }

  var spacingAfter: CGFloat
  var isValid: Bool

  init(
    spacingAfter: CGFloat = 10,
    isValid: Bool = true
  ) {
    self.spacingAfter = spacingAfter
    self.isValid = isValid
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) { nil }
}
