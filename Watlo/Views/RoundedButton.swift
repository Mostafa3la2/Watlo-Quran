//
//  RoundedButton.swift
//  Watlo
//
//  Created by Mostafa Alaa on 8/16/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable  var radius:CGFloat = 5
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = radius
    }
}
