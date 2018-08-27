//
//  werdCell.swift
//  Watlo
//
//  Created by Mostafa Alaa on 8/18/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class werdCell: UICollectionViewCell {
    
    @IBOutlet weak var werdPage: UIImageView!
    
    
    func configureCell(pageNumber:Int){
        let image = UIImage(named: "page\(convertIndexToString(index: pageNumber))")
        werdPage.image = image
    }
    func convertIndexToString(index:Int)->String{
        var stringFormat:String
        if index%10 == index{
            stringFormat = "00\(index)"
        }else if index%100 == index{
            stringFormat = "0\(index)"
        }else{
            stringFormat = "\(index)"
        }
        return stringFormat
    }
}
