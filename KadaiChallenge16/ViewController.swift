//
//  ViewController.swift
//  KadaiChallenge16
//
//  Created by 澤田世那 on 2022/05/31.
//

import UIKit

protocol EditItemListDelegate: AnyObject {
    func addItemDidSave(item: CheckItem)
    func editItemDidSave(name: String)
    func didCancel()
}

class ViewController: UIViewController {
    private var itemList: [CheckItem] = [
        .init(name: "りんご", isChecked: false),
        .init(name: "みかん", isChecked: true),
        .init(name: "バナナ", isChecked: false),
        .init(name: "パイナップル", isChecked: true)
    ]
    private var editIndexPath: IndexPath?

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.nib,
                           forCellReuseIdentifier: ItemTableViewCell.identifier)
    }

    @IBAction func addButtonAction(_ sender: Any) {
        presentAddItemViewController(mode: .add)
    }

    private func presentAddItemViewController(mode: AddItemViewController.Mode) {
        let nextVC = UIStoryboard(name: "AddItem", bundle: nil).instantiateInitialViewController()
        // swiftlint:disable:next force_cast
        as! AddItemViewController
        nextVC.delegate = self
        nextVC.setup(mode: mode)

        let nav = UINavigationController(rootViewController: nextVC)
        present(nav, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier,
                                                 for: indexPath)
        // swiftlint:disable:next force_cast
        as! ItemTableViewCell
        cell.configure(item: itemList[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemList[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        editIndexPath = indexPath
        presentAddItemViewController(mode: .rename(itemList[indexPath.row].name))
    }
}

extension ViewController: EditItemListDelegate {
    func addItemDidSave(item: CheckItem) {
        itemList.append(item)
        dismiss(animated: true)
        tableView.reloadData()
    }

    func editItemDidSave(name: String) {
        guard let editIndexPath = editIndexPath else { return }
        itemList[editIndexPath.row].name = name
        dismiss(animated: true)
        tableView.reloadRows(at: [editIndexPath], with: .automatic)
    }

    func didCancel() {
        dismiss(animated: true)
    }
}
