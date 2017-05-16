//
//  CreateMoneyValueController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit
import CoreData

class CreateMoneyValueController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var expenseIncomeSegment: UISegmentedControl!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var amountInput: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var reacuringTypeSegment: UISegmentedControl!
    
    var categoryController: NSFetchedResultsController<Categories>!
    var allCategories = [Categories]()
    var selectedCategory = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
        var _ = ad.saveContext()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateMoneyValueController.dismissKeyboard)))
        categoryController = NSFetchedResultsController<Categories>()
        attemptFetchCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func attemptFetchCategories() {
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        if let results = try? context.fetch(fetchRequest) {
            if results.count != 0 {
                for obj in results {
                    allCategories.append(obj)
                }
            }
        }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.categoryController = controller
        do {
            try controller.performFetch()
        } catch {
            print("Could not fetch")
        }
    }
    
    func dismissKeyboard() {
        nameInput.resignFirstResponder()
        amountInput.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return allCategories[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategories.count
        
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = allCategories[row].name!
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
        if(nameInput.text == nil) {
            nameInput.text = ""
        }
        card.name = nameInput.text
        if(amountInput.text == nil) {
            amountInput.text = "0.00"
        }
        card.category = selectedCategory
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
