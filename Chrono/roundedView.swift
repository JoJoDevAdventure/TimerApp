//
//  roundedView.swift
//  Chrono
//
//  Created by Youssef Bhl on 07/02/2022.
//

import UIKit

class roundedView: UIVisualEffectView {

    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        roundView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        roundView()
    }
    
    func roundView() {
        let height = self.frame.height
        let width = self.frame.width
        
        let min = height <= width ? height : width
        self.layer.cornerRadius = min/2
    }
    
}
