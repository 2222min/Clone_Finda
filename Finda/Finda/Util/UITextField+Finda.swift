//
//  UITextField+Finda.swift
//  Finda
//
//  Created by mobile on 2022/03/03.
//

import UIKit

extension UITextField {
    
    func underlined(color:UIColor){
        let bottomLine = CALayer()
        let width = CGFloat(1.0)
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  SCREENWIDTH-24, height: width)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
    
    

}
