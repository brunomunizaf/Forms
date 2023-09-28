import XCTest
@testable import Forms

final class FormTextItemTests: XCTestCase {
  func testInitWithAttributes() {
    let text = "Test"
    let spacing: CGFloat = 20
    let attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 12),
      .foregroundColor: UIColor.red
    ]
    let item = FormTextItem(
      text: text,
      attributes: attributes,
      spacingAfter: spacing
    )
    XCTAssertEqual(
      item.spacingAfter, spacing,
      "Spacing after should be initialized correctly"
    )
    XCTAssertEqual(
      item.textLabel.attributedText?.string, text,
      "Text should be initialized correctly"
    )
  }

  func testInitWithFontColor() {
    let text = "Test"
    let font = UIFont.systemFont(ofSize: 16)
    let color = UIColor.blue
    let spacing: CGFloat = 15
    let item = FormTextItem(
      text: text,
      font: font,
      color: color,
      spacingAfter: spacing
    )
    XCTAssertEqual(
      item.spacingAfter, spacing,
      "Spacing after should be initialized correctly"
    )
    XCTAssertEqual(
      item.textLabel.text, text,
      "Text should be initialized correctly"
    )
    XCTAssertEqual(
      item.textLabel.font, font,
      "Font should be initialized correctly"
    )
    XCTAssertEqual(
      item.textLabel.textColor, color,
      "Text color should be initialized correctly"
    )
  }

  func testSubviewSetup() {
    let item = FormTextItem.mock("Test")

    XCTAssertTrue(
      item.subviews.contains(item.textLabel),
      "Text label should be added as a subview"
    )
    XCTAssertFalse(
      item.textLabel.translatesAutoresizingMaskIntoConstraints,
      "Text label should use Auto Layout"
    )
  }

  func testConstraintsSetup() {
    let item = FormTextItem.mock("Test")
    let constraints = item.constraints
    XCTAssert(
      constraints.contains {
        $0.firstAttribute == .top && $0.firstItem === item.textLabel
      }, "TextLabel should have a top constraint"
    )
  }

  func testNumberOfLinesProperty() {
    let item = FormTextItem.mock("Test")
    XCTAssertEqual(
      item.textLabel.numberOfLines, 0,
      "numberOfLines should be 0 to allow multiple lines"
    )
  }

  func testInitWithZeroSpacingAfter() {
    let item = FormTextItem.mock("Test", 0)
    XCTAssertEqual(
      item.spacingAfter, 0,
      "spacingAfter should be initialized to 0 when provided"
    )
  }

  func testInitWithEmptyString() {
    let item = FormTextItem.mock("")
    XCTAssertEqual(
      item.textLabel.text, "",
      "Text should be initialized to an empty string when provided"
    )
  }

  func testConstraintsAreActive() {
    let item = FormTextItem.mock("Test")
    item.layoutIfNeeded()

    for constraint in item.constraints {
      XCTAssertTrue(constraint.isActive, "All constraints should be active")
    }
  }

  func testInitializationUsingNSCoder() {
    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
    let item = FormTextItem(coder: archiver)
    XCTAssertNil(item, "Initialization using NSCoder should return nil")
  }
}

private extension FormTextItem {
  static func mock(
    _ string: String,
    _ spacingAfter: CGFloat = 10
  ) -> FormTextItem {
    FormTextItem(
      text: string,
      font: .systemFont(ofSize: 12),
      color: .black,
      spacingAfter: spacingAfter
    )
  }
}
