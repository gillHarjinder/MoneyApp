//
//  MoneyValueCell.swift
//  MoneyApp
//
//  Created by Brandon Herbert on 5/16/17.
//  Copyright © 2017 Brandon Herbert. All rights reserved.
//

import Foundation
import UIKit

class MoneyValueCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var reacuringImage: UIImageView!
    var repeatImage = UIImage(named: "repeat")
    var singleImage = UIImage(named: "once")
    
    var positiveColor = UIColor(red: 166/256, green: 190/256, blue: 152/256, alpha: 1.0)
    var negativeColor = UIColor(red: 160/256, green: 26/256, blue: 29/256, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 35.0
        layer.masksToBounds = true
    }
    
    func configureCell(card: MoneyValue) {
        switch (card.type) {
        case(false):
            self.backgroundColor = negativeColor
            break
        case(true):
            self.backgroundColor = positiveColor
            break
        }
        name.text = card.name
        date.text = card.date
        amount.text = String(card.amount)
        category.text = card.category
        if(card.reacuring) {
            reacuringImage.image = repeatImage
        } else {
            reacuringImage.image = singleImage
        }
    }
    
}
