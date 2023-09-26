import Forms
import UIKit

final class MinimumFormInputItem: FormInputItem, Validatable {
  var isValid: Bool {
    if let value {
      return !value.isEmpty
    } else {
      return false
    }
  }
}

final class RegexFormInputItem: FormInputItem, Validatable {
  var isValid: Bool {
    guard let value else { return false }

    let regexPattern = "^[0-9]+$"
    do {
      let regex = try NSRegularExpression(pattern: regexPattern)
      let range = NSRange(value.startIndex..., in: value)
      let isMatch = regex.firstMatch(in: value, options: [], range: range) != nil
      return isMatch
    } catch {
      return false
    }
  }
}

final class RequiredFormCheckboxItem: FormCheckboxItem, Validatable {
  var isValid: Bool { isSelected }
}
