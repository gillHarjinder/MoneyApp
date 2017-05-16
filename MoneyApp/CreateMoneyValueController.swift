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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
//        
    }

}
