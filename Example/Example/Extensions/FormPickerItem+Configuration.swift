import Forms
import UIKit

extension FormPickerItem.Configuration {
  static let example = FormPickerItem.Configuration(
    options: [
      ["1", "2", "3", "4"],
      ["5", "6", "7", "8"],
      ["9", "10", "11", "12"],
      ["13", "14", "15", "16"]
    ],
    selectedOption: nil,
    spacingAfter: 10
  )
}
