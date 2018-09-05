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
    
    @IBOutlet weak var currentPageLbl: UILabel!
    
    func configureCell(pageNumber:Int){
        let image = UIImage(named: "page\(convertIndexToString(index: pageNumber))")
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_EG")
        let number = format.number(from: String(pageNumber))
        let ARnumber = format.string(from: number!)
        currentPageLbl.text = ARnumber
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
