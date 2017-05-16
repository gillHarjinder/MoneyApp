//
//  ViewController.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 4/29/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var posNegLabel: UILabel!
    
    var positiveColor = UIColor(red: 166/256, green: 190/256, blue: 152/256, alpha: 1.0)
    var negativeColor = UIColor(red: 160/256, green: 26/256, blue: 29/256, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posNegLabel.textColor = positiveColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CreateCatogories(_ sender: Any) {
        
        self.performSegue(withIdentifier: "CREATE", sender: self)
    }

    @IBAction func addExpances(_ sender: Any) {
        self.performSegue(withIdentifier: "ADD_EXPANSE", sender: self)
    }
}

