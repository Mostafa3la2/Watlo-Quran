//
//  ViewController.swift
//  Watlo
//
//  Created by Mostafa Alaa on 8/15/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class SelectPreferencesVC: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var dailyLoadPickerTextBox: UITextField!
    @IBOutlet weak var numberOfDays: UITextField!
    @IBOutlet weak var favTimeTextBox: UITextField!
    var dayPickOption : [days] = [.week , .fortnight , .threeWeeks , .month , .monthAndHalf , .twoMonths]
    var pickOption=["١","٢","٣","٥","٧","١٠","١٢","١٥","٢٠"]
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView(withIdentifier: "daily", withBarLabel: "اختر المقدار اليومي للقراءة", withPlaceHolderText: "صفحة",textboxToAttach: dailyLoadPickerTextBox)
        setupPickerView(withIdentifier: "days", withBarLabel: "اختر مدة الختمة", withPlaceHolderText: "يوم",textboxToAttach: numberOfDays)
        setupTimePicker()
        //adding tap gesture to close the textboxes
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapAnywhereToDismiss))
        view.addGestureRecognizer(tapToDismiss)
    }
    @objc func tapAnywhereToDismiss(){
        dailyLoadPickerTextBox.endEditing(true)
        favTimeTextBox.endEditing(true)
        numberOfDays.endEditing(true)
    }
    @objc func donePressed(sender: UIBarButtonItem) {
            dailyLoadPickerTextBox.resignFirstResponder()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.accessibilityIdentifier == "daily"{
            return pickOption.count}
        else {
            return dayPickOption.count
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.accessibilityIdentifier == "daily"{
            return pickOption[row]
        }else{
            return dayPickOption[row].rawValue
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.accessibilityIdentifier == "daily"{
            dailyLoadPickerTextBox.text = pickOption[row]
        }else{
          numberOfDays.text = dayPickOption[row].rawValue
        }
    }
   
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        if pickerView.accessibilityIdentifier == "daily"{
             titleData = pickOption[row]
        }else{
             titleData = dayPickOption[row].rawValue
        }
        let attributedString = NSAttributedString(string: String(titleData), attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 0.6352856815, blue: 0.01489391638, alpha: 1)])
        return attributedString
    }
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = NSLocale(localeIdentifier: "AR") as Locale
        favTimeTextBox.text = dateFormatter.string(from: sender.date)
    }
    func setupPickerView(withIdentifier:String,withBarLabel:String,withPlaceHolderText:String,textboxToAttach:UITextField){
        let pickerView = UIPickerView()
        pickerView.accessibilityIdentifier = withIdentifier
        pickerView.setValue(#colorLiteral(red: 0.4725372779, green: 0.150406516, blue: 0.1655853387, alpha: 1), forKey: "backgroundColor")
        pickerView.delegate = self
        let toolBar = UIToolbar(frame: CGRect.init(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .black
        toolBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.backgroundColor = #colorLiteral(red: 0.4725372779, green: 0.150406516, blue: 0.1655853387, alpha: 1)
        //let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SelectPreferencesVC.donePressed))
       // doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:#colorLiteral(red: 1, green: 0.6352856815, blue: 0.01489391638, alpha: 1) ], for: .normal)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Damascus", size: 16)
        label.backgroundColor = UIColor.clear
        label.textColor = #colorLiteral(red: 1, green: 0.6352856815, blue: 0.01489391638, alpha: 1)
        label.text = withBarLabel
        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        let dailyLoadPlaceholder : NSAttributedString = NSAttributedString(string:withPlaceHolderText, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.4725372779, green: 0.150406516, blue: 0.1655853387, alpha: 0.3)])
        textboxToAttach.attributedPlaceholder = dailyLoadPlaceholder
        //toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        toolBar.setItems([flexSpace,textBtn,flexSpace], animated: true)
        textboxToAttach.inputView = pickerView
        textboxToAttach.inputAccessoryView = toolBar
    }
    func setupTimePicker(){
        let timePickerView = UIDatePicker()
        timePickerView.datePickerMode = .time
        timePickerView.locale = NSLocale(localeIdentifier: "AR") as Locale
        timePickerView.setValue(#colorLiteral(red: 1, green: 0.6352856815, blue: 0.01489391638, alpha: 1), forKey: "textColor")
        timePickerView.setValue(#colorLiteral(red: 0.4725372779, green: 0.150406516, blue: 0.1655853387, alpha: 1), forKey: "backgroundColor")
        timePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        let favTimePlaceholder : NSAttributedString = NSAttributedString(string: "٦:٥٣ م", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.4725372779, green: 0.150406516, blue: 0.1655853387, alpha: 0.3)])
        favTimeTextBox.attributedPlaceholder = favTimePlaceholder
        favTimeTextBox.inputView = timePickerView
    }
   
    @IBAction func continueBtnPressed(_ sender: Any) {
        /*if let dailyAmount = dailyLoadPickerTextBox.text, let favTime = favTimeTextBox.text{
            let Formatter = NumberFormatter()
            Formatter.locale = Locale(identifier: "EN") as Locale
            let englishStringFromNumber = Formatter.number(from: dailyAmount)?.stringValue
            UserSettings.instance.dailyAmount = englishStringFromNumber
            UserSettings.instance.favTime = favTime
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "werd")
            self.present(nextViewController,animated: true,completion: nil)
        }*/
        if let favTime = favTimeTextBox.text {
                let dailyAmount = dailyLoadPickerTextBox.text
                if dailyAmount != nil && dailyAmount! != ""{
                    print(dailyAmount!)
                if numberOfDays.text == nil || numberOfDays.text! == ""{
                    let Formatter = NumberFormatter()
                    Formatter.locale = Locale(identifier: "EN") as Locale
                    let englishStringFromNumber = Formatter.number(from: dailyAmount!)?.stringValue
                    UserSettings.instance.dailyAmount = englishStringFromNumber
                    UserSettings.instance.favTime = favTime
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "werd")
                    self.present(nextViewController,animated: true,completion: nil)
                }
            }
            else if let day = numberOfDays.text{
                print("here")
                    
                    var dailyAmount = ""
                    var lastDay = 0
                    let daysEnum = days(rawValue:day)!
                    switch daysEnum{
                    case .week:
                        dailyAmount = String(604/7)
                        lastDay = 604%7
                    case .fortnight:
                        dailyAmount = String(604/14)
                        lastDay = 604%14
                    case .threeWeeks:
                        dailyAmount = String(29)
                        lastDay = 24
                    case .month:
                        dailyAmount = String(604/30)
                        lastDay = 24
                    case .monthAndHalf:
                        dailyAmount = String(604/45)
                        lastDay = 19
                    case .twoMonths:
                        dailyAmount = String(604/60)
                        lastDay = 14
                   
                }
                    UserSettings.instance.favTime = favTime
                    UserSettings.instance.dailyAmount = dailyAmount
                    UserSettings.instance.lastDay = lastDay
                    UserSettings.instance.khatmaType = true
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "werd")
                    self.present(nextViewController,animated: true,completion: nil)
            }
        }
    }
   
    @IBAction func selectedDaily(_ sender: Any) {
        numberOfDays.text = ""
    }
    
    @IBAction func selectedDays(_ sender: Any) {
        dailyLoadPickerTextBox.text = ""
    }
}

