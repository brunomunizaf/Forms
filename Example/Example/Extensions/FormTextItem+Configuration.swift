import Forms
import UIKit

extension FormTextItem.Configuration {
  static func subtitle() -> FormTextItem.Configuration {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4

    return FormTextItem.Configuration(
      text: "Your new password must be unique therefore different than the previously used.",
      attributes: [
        .font: UIFont(name: "Helvetica", size: 13)!,
        .foregroundColor: UIColor.gray,
        .kern: 0.1,
        .paragraphStyle: paragraphStyle
      ],
      spacingAfter: 30
    )
  }

  static let title = FormTextItem.Configuration(
    text: "Create a new password",
    attributes: [
      .font: UIFont(name: "Helvetica-bold", size: 35)!,
      .foregroundColor: UIColor.black
    ],
    spacingAfter: 15
  )
}
