import UIKit

/// `FormPickerItem` represents a form component for selecting a single
/// combination from a list of options.
///
/// It offers extensive customization possibilities, allowing adjustments to visual elements
/// to achieve a coherent and aesthetically pleasing user interface.
///
/// - Note: This class conforms to the `FormItem` protocol.
open class FormPickerItem: UIView, FormItem, UIPickerViewDataSource, UIPickerViewDelegate {

  /// A structure used to configure a `FormPickerItem`.
  ///
  /// It holds all the customizable parameters, which include visual attributes
  /// and spacing information for the picker in the form.
  public struct Configuration {
    let options: [[String]]
    let selectedOption: String?
    let spacingAfter: CGFloat

    /// Creates a new instance of `FormPickerItem.Configuration`.
    /// - Parameters:
    ///   - options: The array of strings to be displayed as options in the picker.
    ///   - selectedOption: The initially selected option in the picker.
    ///   - spacingAfter: The space after the picker item in the form.
    public init(
      options: [[String]],
      selectedOption: String?,
      spacingAfter: CGFloat
    ) {
      self.options = options
      self.selectedOption = selectedOption
      self.spacingAfter = spacingAfter
    }
  }

  private(set) var pickerView = UIPickerView()

  /// Array of options to be displayed in the picker.
  private let options: [[String]]

  /// The currently selected option in the picker.
  private var selectedOption: String? {
    didSet {
      guard let selectedOption = selectedOption else { return }
      if let (outerIndex, innerArray) = options.enumerated().first(where: { $1.contains(selectedOption) }),
         let innerIndex = innerArray.firstIndex(of: selectedOption) {
        pickerView.selectRow(innerIndex, inComponent: outerIndex, animated: true)
      }
    }
  }

  /// The space after the input item in the form.
  public let spacingAfter: CGFloat

  /// Initializes a new instance of `FormPickerItem`.
  /// - Parameters:
  ///   - configuration: The model containing all the attributes of the picker item.
  public init(configuration: Configuration) {
    options = configuration.options
    spacingAfter = configuration.spacingAfter
    selectedOption = configuration.selectedOption

    super.init(frame: .zero)
    setupSubviews()

    pickerView.delegate = self
    pickerView.dataSource = self
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets up the user interface components.
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
