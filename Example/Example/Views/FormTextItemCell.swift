import Forms
import UIKit

final class FormTextItemCell: UITableViewCell {
  private let textItem: FormTextItem

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    self.textItem = FormTextItem(configuration: .default)
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupTextItem()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupTextItem() {
    contentView.addSubview(textItem)
    textItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textItem.topAnchor.constraint(equalTo: contentView.topAnchor),
      textItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      textItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      textItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }

  func configure(with configuration: FormTextItem.Configuration) {
    textItem.textLabel.attributedText = NSAttributedString(
      string: configuration.text,
      attributes: configuration.attributes
    )
    textItem.spacingAfter = 10
  }
}

extension FormTextItem.Configuration {
  static let `default` = FormTextItem.Configuration(
    text: "...",
    attributes: [:],
    spacingAfter: 0
  )
}
