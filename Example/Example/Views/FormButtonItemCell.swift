import Forms
import UIKit

final class FormButtonItemCell: UITableViewCell {
  private let buttonItem: FormButtonItem

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    self.buttonItem = FormButtonItem(configuration: .default)
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupButtonItem()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupButtonItem() {
    contentView.addSubview(buttonItem)
    buttonItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      buttonItem.topAnchor.constraint(equalTo: contentView.topAnchor),
      buttonItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      buttonItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      buttonItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }

  func configure(with configuration: FormButtonItem.Configuration) {
    buttonItem.titleLabel.attributedText = NSAttributedString(
      string: configuration.title,
      attributes: configuration.attributes
    )
  }
}

extension FormButtonItem.Configuration {
  static let `default` = FormButtonItem.Configuration(
    title: "...",
    attributes: [:],
    enabledColor: .clear,
    disabledColor: .clear,
    borderWidth: 0,
    borderColor: .clear,
    cornerRadius: 0,
    spacingAfter: 0,
    shouldBeEnabled: false
  )
}
