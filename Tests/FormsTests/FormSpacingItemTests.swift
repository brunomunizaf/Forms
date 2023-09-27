import XCTest
@testable import Forms

final class FormSpacingItemTests: XCTestCase {
  func testInitWithFixedHeight() {
    let fixedHeight: CGFloat = 50
    let spacingAfter: CGFloat = 10
    let item = FormSpacingItem(
      fixedHeight: fixedHeight,
      spacingAfter: spacingAfter
    )
    XCTAssertEqual(
      item.spacingAfter, spacingAfter,
      "Spacing after should be initialized correctly"
    )
    let heightConstraint = item.constraints.first { $0.firstAttribute == .height }
    XCTAssertNotNil(
      heightConstraint, 
      "Height constraint should be set"
    )
    XCTAssertEqual(
      heightConstraint?.constant, fixedHeight,
      "Height constraint should be equal to fixed height provided"
    )
  }

  func testInitWithoutFixedHeight() {
    let spacingAfter: CGFloat = 10
    let item = FormSpacingItem(spacingAfter: spacingAfter)
    XCTAssertEqual(
      item.spacingAfter, spacingAfter,
      "Spacing after should be initialized correctly"
    )
    let heightConstraint = item.constraints.first { $0.firstAttribute == .height }
    XCTAssertNil(
      heightConstraint,
      "There should be no height constraint if no fixed height is provided"
    )
  }

  func testContentHuggingPriority() {
    let item = FormSpacingItem()
    XCTAssertEqual(
      item.contentHuggingPriority(for: .vertical), .defaultLow,
      "Content hugging priority for vertical should be .defaultLow"
    )
    XCTAssertEqual(
      item.contentHuggingPriority(for: .horizontal), .defaultLow,
      "Content hugging priority for horizontal should be .defaultLow"
    )
  }

  func testInitializationUsingNSCoder() {
    let archiver = NSKeyedArchiver(requiringSecureCoding: false)
    let item = FormSpacingItem(coder: archiver)
    XCTAssertNil(item, "Initialization using NSCoder should return nil")
  }
}
