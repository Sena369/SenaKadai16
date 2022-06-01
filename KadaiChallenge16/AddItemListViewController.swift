//
//  AddItemViewController.swift
//  KadaiChallenge16
//
//  Created by 澤田世那 on 2022/06/01.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet private weak var itemTextField: UITextField!

    weak var delegate: EditItemListDelegate?
    private var modalIdentifier = ""
    private var nameText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = nameText
    }

    @IBAction func saveButton(_ sender: Any) {
        guard let text = itemTextField.text else { return }
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        if modalIdentifier == "Add" {
            delegate?.addItemDidSave(item: .init(name: text, isChecked: false))
        } else {
            delegate?.editItemDidSave(name: text)
        }
    }

    @IBAction func cancelButton(_ sender: Any) {
        delegate?.didCancel()
    }

    func receiveModalInfo(identifier: String, name: String) {
        modalIdentifier = identifier
        nameText = name
    }
}
