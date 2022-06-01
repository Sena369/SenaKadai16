//
//  AddItemViewController.swift
//  KadaiChallenge16
//
//  Created by 澤田世那 on 2022/06/01.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemTextField: UITextField!

    weak var delegate: ItemDelegate?

//    static func instantiate(didSave: @escaping (CheckItem) -> Void,
//                            didCancel: @escaping () -> Void) -> AddItemViewController {
//    }

//    private var didSave: (CheckItem) -> Void = { _ in }
//    private var didCancel: () -> Void = {}

    @IBAction func savrButton(_ sender: Any) {
        delegate?.didSave(item: .init(name: itemTextField.text ?? "",
                                      isChecked: false))
    }

    @IBAction func cancelButton(_ sender: Any) {
        delegate?.didCancel()
    }
    
}
