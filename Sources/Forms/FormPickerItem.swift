import UIKit

open class FormPickerItem: UIView, FormItem, UIPickerViewDataSource, UIPickerViewDelegate {
  private(set) var pickerView = UIPickerView()

  private let options: [[String]]

  private var selectedOption: String? {
    didSet {
      guard let selectedOption = selectedOption else { return }
      if let (outerIndex, innerArray) = options.enumerated().first(where: { $1.contains(selectedOption) }),
         let innerIndex = innerArray.firstIndex(of: selectedOption) {
        pickerView.selectRow(innerIndex, inComponent: outerIndex, animated: true)
      }
    }
  }

  public let spacingAfter: CGFloat

  public init(
    options: [[String]],
    selectedOption: String?,
    spacingAfter: CGFloat = 10
  ) {
    self.options = options
    self.spacingAfter = spacingAfter
    self.selectedOption = selectedOption

    super.init(frame: .zero)
    setupSubviews()

    pickerView.delegate = self
    pickerView.dataSource = self
  }

  required public init?(coder: NSCoder) { nil }

  private func setupSubviews() {
    addSubview(pickerView)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pickerView.topAnchor.constraint(equalTo: topAnchor),
      pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

public extension FormPickerItem {
  func numberOfComponents(
    in pickerView: UIPickerView
  ) -> Int {
    options.count
  }

  func pickerView(
    _ pickerView: UIPickerView,
    numberOfRowsInComponent component: Int
  ) -> Int {
    options[component].count
  }

  func pickerView(
    _ pickerView: UIPickerView,
    titleForRow row: Int,
    forComponent component: Int
  ) -> String? {
    options[component][row]
  }

  func pickerView(
    _ pickerView: UIPickerView,
    didSelectRow row: Int,
    inComponent component: Int
  ) {
    selectedOption = options[component][row]
  }
}
