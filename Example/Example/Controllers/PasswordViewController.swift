import Forms
import UIKit

final class PasswordViewController: UIViewController {
  private var formItems: [FormItemType] = []
  private let tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(FormTextItemCell.self, forCellReuseIdentifier: "textCell")
    tableView.register(FormInputItemCell.self, forCellReuseIdentifier: "inputCell")
    tableView.register(FormButtonItemCell.self, forCellReuseIdentifier: "buttonCell")
    tableView.register(FormCheckboxItemCell.self, forCellReuseIdentifier: "checkboxCell")

    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self

    setupTableView()
    loadFormItems()
  }

  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
  }

  private func loadFormItems() {
    formItems = [
      .text(.init(
        text: "Choose your secure password",
        attributes: [
          .font: UIFont(name: "AvenirNext-DemiBold", size: 24)!,
          .foregroundColor: UIColor.black,
          .kern: 0.5
        ],
        spacingAfter: 15
      )),
      .text(.init(
        text: "Insert your secure password to keep your profile safe.",
        attributes: [
          .font: UIFont(name: "AvenirNext-Regular", size: 16)!,
          .foregroundColor: UIColor.darkGray,
          .kern: 0.2
        ],
        spacingAfter: 30
      )),
      .button(.init(
        title: "Confirm Password",
        attributes: [
          .font: UIFont(name: "AvenirNext-DemiBold", size: 18)!,
          .foregroundColor: UIColor.black
        ],
        enabledColor: .systemBlue,
        disabledColor: .systemGray,
        borderWidth: 2,
        borderColor: .systemBlue,
        cornerRadius: 8,
        spacingAfter: 20,
        shouldBeEnabled: true
      ))
    ]
  }
}

extension PasswordViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return formItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemType = formItems[indexPath.row]

    switch itemType {
    case .button(let configuration):
      let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! FormButtonItemCell
      cell.configure(with: configuration)
      return cell

    case .text(let configuration):
      let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! FormTextItemCell
      cell.configure(with: configuration)
      return cell

    case .input(let configuration):
      let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! FormInputItemCell
      cell.configure(with: configuration)
      return cell

    case .checkbox(let configuration):
      let cell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! FormCheckboxItemCell
      cell.configure(with: configuration)
      return cell
    }
  }
}

final class FormInputItemCell: UITableViewCell {
  func configure(with configuration: FormInputItem.Configuration) {
    // TODO: ...
  }
}

final class FormCheckboxItemCell: UITableViewCell {
  func configure(with configuration: FormCheckboxItem.Configuration) {
    // TODO: ...
  }
}

