//
//  ViewController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 4/29/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var posNegLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    
    var allCards = [MoneyValue]()
    var allCategories = [Categories]()
    var positiveColor = UIColor(red: 166/256, green: 190/256, blue: 152/256, alpha: 1.0)
    var negativeColor = UIColor(red: 160/256, green: 26/256, blue: 29/256, alpha: 1.0)
    var moneyValueController: NSFetchedResultsController<MoneyValue>!
    var categoryController: NSFetchedResultsController<Categories>!
    var totalIncome = 0.0
    var didAlreadyLoad = Bool(false)
    var hasCategory = Bool(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posNegLabel.textColor = positiveColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !didAlreadyLoad {
            var _ = ad.saveContext()
            moneyValueController = NSFetchedResultsController<MoneyValue>()
            categoryController = NSFetchedResultsController<Categories>()
            attemptFetchMoneyValues()
            attemptFetchCategories()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func countExpense() {
        for card in allCards {
            if(card.type) {
                totalIncome += card.amount
            } else {
                totalIncome -= card.amount
            }
        }
        if(totalIncome < 0.0) {
            incomeLabel.textColor = negativeColor
        } else {
            incomeLabel.textColor = positiveColor
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        if(totalIncome == 0.0) {
            incomeLabel.text = "$0" + numberFormatter.string(from: NSNumber(floatLiteral: totalIncome))!
        } else {
            incomeLabel.text = "$" + numberFormatter.string(from: NSNumber(floatLiteral: totalIncome))!
        }
    }
    
    func attemptFetchMoneyValues() {
        let fetchRequest: NSFetchRequest<MoneyValue> = MoneyValue.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        if let results = try? context.fetch(fetchRequest) {
            if results.count != 0 {
                for obj in results {
                    allCards.append(obj)
                }
            }
        }
        countExpense()
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.moneyValueController = controller
        do {
            try moneyValueController.performFetch()
        } catch {
            print("Could not fetch")
        }
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
        if allCategories.count > 0 {
            hasCategory = true
        }
        countExpense()
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.categoryController = controller
        do {
            try controller.performFetch()
        } catch {
            print("Could not fetch")
        }
    }

    @IBAction func CreateCatogories(_ sender: Any) {
        self.performSegue(withIdentifier: "CREATE", sender: self)
    }

    @IBAction func addExpances(_ sender: Any) {
        if(hasCategory) {
            self.performSegue(withIdentifier: "ADD_EXPANSE", sender: self)
        } else {
            let alertController = UIAlertController(title: "No categories found", message:
                "You must add a category first", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

