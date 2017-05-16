//
//  CustomNavigationBar.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationController {

    var textColor = UIColor(red: 251/256, green: 246/256, blue: 241/256, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
