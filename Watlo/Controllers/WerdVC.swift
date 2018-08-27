//
//  WerdVC.swift
//  Watlo
//
//  Created by Mostafa Alaa on 8/17/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class WerdVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    

    @IBOutlet weak var settingsBtnViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsBtnView: UIView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var currentPageLbl: UILabel!
    @IBOutlet weak var khatmaFinished: UIView!
    
    @IBOutlet weak var finishedView: UIView!
    @IBOutlet weak var pagesCollectionView: UICollectionView!
    
    var startIndex = 0
    var amount = 0
    var maxWerd = 0
    var currentIndex = 0
    var clickedIndex = 0
    var settingsShown = false
    override func viewDidLoad() {
        super.viewDidLoad()
        pagesCollectionView.backgroundColor = #colorLiteral(red: 0.9654220679, green: 1, blue: 0.5942987538, alpha: 0.35)
        pagesCollectionView.delegate=self
        pagesCollectionView.dataSource=self
        pagesCollectionView.isPagingEnabled = true
        
        if UserSettings.instance.khatmaType! {
            let currentPage = UserSettings.instance.currentPage!
            let lastDay = UserSettings.instance.lastDay!
            if currentPage+lastDay == 604{
                amount = lastDay
            }else{
                amount = Int(UserSettings.instance.dailyAmount!)!
            }
        }else{
            amount = Int(UserSettings.instance.dailyAmount!)!
        }
        
        if UserSettings.instance.currentPage == 0{
            startIndex = 1
        }else{
        startIndex = UserSettings.instance.currentPage!
        }
        
        currentIndex = startIndex
        maxWerd = startIndex+amount
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(animateSettingsBtnView))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        pagesCollectionView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        pagesCollectionView.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
        
      
    }
    @objc func doubleTapped(){
        if clickedIndex == amount-1{
            if startIndex+amount != 604{
            finishedView.isHidden = false
            UserSettings.instance.currentPage = startIndex+amount
            }else{
                khatmaFinished.isHidden = false
            }
        }
    }
    @objc func animateSettingsBtnView(){
        if !settingsShown{
            settingsBtnViewConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            settingsShown = true
        }else{
            settingsBtnViewConstraint.constant = -200
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            settingsShown = false
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "werdCell", for: indexPath) as? werdCell else{
            return UICollectionViewCell()
        }
        cell.configureCell(pageNumber: currentIndex+indexPath.row)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_EG")
        let number = format.number(from: String(currentIndex+indexPath.row))
        let ARnumber = format.string(from: number!)
        currentPageLbl.text = ARnumber
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedIndex = indexPath.row
    }
    @IBAction func continueBtnPressed(_ sender: Any) {
        pagesCollectionView.reloadData()
        finishedView.isHidden = true
        currentIndex = startIndex+amount
        startIndex = currentIndex
        let indexpathForFirstElement = IndexPath(row: 0, section: 0)
        pagesCollectionView.selectItem(at: indexpathForFirstElement, animated: true, scrollPosition: .right)
    }
    @IBAction func notNotBtnPressed(_ sender: Any) {
        finishedView.isHidden = true
    }
    
    @IBAction func khatmaFinishedDismissPressed(_ sender: Any) {
        khatmaFinished.isHidden = true
    }
    @IBAction func startNewKhatma(_ sender: Any) {
        UserSettings.instance.currentPage = 0
        UserSettings.instance.khatmaType = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "preferences")
        self.present(nextViewController,animated: true,completion: nil)
    }
    @IBAction func closeSettings(_ sender: Any) {
        settingsView.isHidden = true
    }
    @IBAction func showSettings(_ sender: Any) {
        settingsView.isHidden = false
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
