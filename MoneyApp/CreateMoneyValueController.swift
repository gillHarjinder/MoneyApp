//
//  CreateMoneyValueController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit

class CreateMoneyValueController: UIViewController {

    @IBOutlet weak var expenseIncomeSegment: UISegmentedControl!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var reacuringTypeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _ = ad.saveContext()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateMoneyValueController.dismissKeyboard)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        nameInput.resignFirstResponder()
        amountInput.resignFirstResponder()
    }
    
    func saveCard() {
        let card = MoneyValue(context: context)
        switch expenseIncomeSegment.selectedSegmentIndex {
        case 0:
            card.type = false
        case 1:
            card.type = true
        default:
            break;
        }
        switch reacuringTypeSegment.selectedSegmentIndex {
        case 0:
            card.reacuring = false
        case 1:
            card.reacuring = true
        default:
            break;
        }
        card.name = nameInput.text
        if(amountInput.text == nil) {
            amountInput.text = "0.00"
        }
        card.amount = Double(amountInput.text!)!
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        card.date = dateString
        let passes = ad.saveContext()
        if !passes {
            context.delete(card)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        saveCard()
        let _ = navigationController?.popViewController(animated: true)
    }

}
