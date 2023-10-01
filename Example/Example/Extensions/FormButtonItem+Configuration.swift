import Forms
import UIKit

extension FormButtonItem.Configuration {
  static let regularStyle = FormButtonItem.Configuration(
    title: "Continue",
    font: UIFont(name: "Helvetica-bold", size: 18)!,
    textColor: .white,
    enabledColor: .systemTeal,
    disabledColor: .lightGray,
    borderWidth: 2.0,
    borderColor: .darkGray,
    cornerRadius: 30.0,
    spacingAfter: 0,
    shouldBeEnabled: false
  )

  static let subtleProfessional = FormButtonItem.Configuration(
    title: "Proceed",
    font: UIFont(name: "ArialMT", size: 16)!,
    textColor: .black,
    enabledColor: .systemGreen,
    disabledColor: .systemGray4,
    borderWidth: 1.0,
    borderColor: .systemGray,
    cornerRadius: 8.0,
    spacingAfter: 10,
    shouldBeEnabled: true
  )

  static let boldEnergetic = FormButtonItem.Configuration(
    title: "Let's Go!",
    font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,
    textColor: .white,
    enabledColor: .systemRed,
    disabledColor: .systemGray2,
    borderWidth: 2.0,
    borderColor: .systemRed,
    cornerRadius: 15.0,
    spacingAfter: 15,
    shouldBeEnabled: false
  )

  static let modernElegant = FormButtonItem.Configuration(
    title: "Next",
    font: UIFont(name: "AvenirNext-DemiBold", size: 18)!,
    textColor: .white,
    enabledColor: .systemBlue,
    disabledColor: .systemGray3,
    borderWidth: 1.5,
    borderColor: .systemBlue,
    cornerRadius: 20.0,
    spacingAfter: 20,
    shouldBeEnabled: true
  )
}
