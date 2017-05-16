//
//  CreateCategoryController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit
import CoreData


class CreateCategoryController: UIViewController {
    
    
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var descriptionTexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ = ad.saveContext()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateMoneyValueController.dismissKeyboard)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        nameTextFeild.resignFirstResponder()
        descriptionTexField.resignFirstResponder()
    }
    
    func saveCat() {
        let cat = Categories(context: context)
        if nameTextFeild.text == nil {
            nameTextFeild.text = " "
        }
        if descriptionTexField.text == nil {
            descriptionTexField.text = " "
        }
        cat.name = nameTextFeild.text
        cat.desc = descriptionTexField.text
        let passes = ad.saveContext()
        if !passes {
            context.delete(cat)
        }
    }
    @IBAction func makeCategory(_ sender: Any) {
        saveCat()
        let _ = navigationController?.popViewController(animated: true)
    }
}
