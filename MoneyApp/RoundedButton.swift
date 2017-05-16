//
//  RoundedButton.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}
