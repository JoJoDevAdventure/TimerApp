//
//  CustomCellTableViewCell.swift
//  Chrono
//
//  Created by Youssef Bhl on 07/02/2022.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var timesNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timeNumber : Int?
    var timeText : String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        guard let timeNumber = timeNumber else {
            return
        }
        guard let timeText = timeText else {
            return
        }
        
        let timeNumberString = String(format: "%02d", timeNumber)
        
        timeLabel.text = timeText
        timesNumberLabel.text = timeNumberString
    }
    

    

}
