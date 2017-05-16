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
    var singleImage = UIImage(named: "single")
    
    var positiveColor = UIColor(red: 166/256, green: 190/256, blue: 152/256, alpha: 1.0)
    var negativeColor = UIColor(red: 160/256, green: 26/256, blue: 29/256, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 35.0
        layer.masksToBounds = true
    }
    
    func configureCell(card: MoneyValue) {
        var type = card.type
        if(type) {
            self.backgroundColor = positiveColor
        } else {
            self.backgroundColor = negativeColor
        }
        if let cardName = card.name {
            name.text = cardName
        }
        if let cardDate = card.date {
            date.text = cardDate
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        amount.text = "$" + numberFormatter.string(from: NSNumber(floatLiteral: card.amount))!
        category.text = card.category
        if(card.reacuring) {
            reacuringImage.image = repeatImage
        } else {
            reacuringImage.image = singleImage
        }
    }
    
}
