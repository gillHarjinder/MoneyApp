//
//  ListController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit
import CoreData

class ListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var controller: NSFetchedResultsController<MoneyValue>!
    var didAlreadyLoad = Bool(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !didAlreadyLoad {
            var _ = ad.saveContext()
            controller = NSFetchedResultsController<MoneyValue>()
            attemptFetch()
            listCollectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoneyValueCell", for: indexPath) as! MoneyValueCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                listCollectionView.insertItems(at: [indexPath])
            }
            break
        case.delete:
            if let indexPath = indexPath {
                listCollectionView.deleteItems(at: [indexPath])
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = listCollectionView.cellForItem(at: indexPath) as! MoneyValueCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                listCollectionView.deleteItems(at: [indexPath])
            }
            if let indexPath = newIndexPath {
                listCollectionView.insertItems(at: [indexPath])
            }
            break
        }
    }
    
    func configureCell(cell: MoneyValueCell, indexPath: NSIndexPath) {
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(card: item)
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<MoneyValue> = MoneyValue.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller = controller
        do {
            try controller.performFetch()
        } catch {
            print("Could not fetch")
        }
        listCollectionView.reloadData()
    }
    
    

}
