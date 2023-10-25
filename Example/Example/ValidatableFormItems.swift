import Forms
import UIKit

/// `MinimumFormInputItem` is a subclass of `FormInputItem` and conforms to `Validatable`.
/// It considers the item valid if the value is not empty.
final class MinimumFormInputItem: FormInputItem, Validatable {
  /// A computed property to check if the value of the form input item is valid.
  var isValid: Bool {
    guard let value = value else { return false }
    return !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}

/// `RegexFormInputItem` is a subclass of `FormInputItem` and conforms to `Validatable`.
/// It considers the item valid if the value matches a regex pattern, which is a string containing only digits.
final class RegexFormInputItem: FormInputItem, Validatable {
  /// A computed property to check if the value of the form input item is valid according to the regex pattern.
  var isValid: Bool {
    guard let value else { return false }

    /// The regex pattern used to validate the value. It checks if the value is a string containing only digits.
    let regexPattern = "^[0-9]+$"
    do {
      let regex = try NSRegularExpression(pattern: regexPattern)
      let range = NSRange(value.startIndex..., in: value)
      let isMatch = regex.firstMatch(in: value, options: [], range: range) != nil
      return isMatch
    } catch {
      // Log or handle the error when creating the NSRegularExpression fails.
      print("Invalid regex pattern: \(error.localizedDescription)")
      return false
    }
  }
}

/// `RequiredFormCheckboxItem` is a subclass of `FormCheckboxItem` and conforms to `Validatable`.
/// It considers the item valid if it is selected.
final class RequiredFormCheckboxItem: FormCheckboxItem, Validatable {

  /// A computed property to check if the value is valid.
  var isValid: Bool { value == true }
}

/// `RequiredFormSwitchItem` is a subclass of `FormSwitchItem` and conforms to `Validatable`.
/// It considers the item valid if it is enabled.
final class RequiredFormSwitchItem: FormSwitchItem, Validatable {

  /// A computed property to check if the value is valid.
  var isValid: Bool { value == true }
}
