//
//  ViewController.swift
//  KadaiChallenge16
//
//  Created by 澤田世那 on 2022/05/31.
//

import UIKit

protocol ItemDelegate: AnyObject {
    func addDidSave(item: CheckItem) -> Void
    func editDidSave(name: String) -> Void
    func didCancel() -> Void
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemDelegate {

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
        let nextVC = UIStoryboard(name: "AddItem", bundle: nil).instantiateInitialViewController()
        // swiftlint:disable:next force_cast
        as! AddItemViewController
        nextVC.delegate = self
        nextVC.receiveModalInfo(identifier: "Add", name: "")

        let nav = UINavigationController(rootViewController: nextVC)
        present(nav, animated: true)
    }

    func addDidSave(item: CheckItem) {
        itemList.append(item)
        dismiss(animated: true)
        tableView.reloadData()
    }

    func editDidSave(name: String) {
        guard let editIndexPath = editIndexPath else { return }
        itemList[editIndexPath.row].name = name
        tableView.reloadRows(at: [editIndexPath], with: .automatic)
        dismiss(animated: true)
    }

    func didCancel() {
        dismiss(animated: true)
    }

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemList[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "AddItem", bundle: nil).instantiateInitialViewController()
        // swiftlint:disable:next force_cast
        as! AddItemViewController
        nextVC.delegate = self
        nextVC.receiveModalInfo(identifier: "Edit", name: itemList[indexPath.row].name)
        editIndexPath = indexPath

        let nav = UINavigationController(rootViewController: nextVC)
        present(nav, animated: true)
    }
}

