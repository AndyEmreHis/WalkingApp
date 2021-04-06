//
//  AddActivityViewController.swift
//  WalkingApp
//
//  Created by Andy Emre Kocak on 2/17/21.
//

import UIKit
import Firebase
class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var ActivityDateField: UITextField!
    
    let ActivityDatePicker = UIDatePicker()
    
    var emailName = ""
    
    var activityChosen = ""
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatepicker()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatepicker() {
        ActivityDatePicker.preferredDatePickerStyle = .wheels
        ActivityDatePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        
        ActivityDateField.inputView = ActivityDatePicker
        ActivityDateField.inputAccessoryView = createToolbar()
        
        
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        
        self.ActivityDateField.text = dateFormatter.string(from: ActivityDatePicker.date)
    }
    
    @IBAction func finishedPressed(_ sender: Any) {
        
        var hourString = ActivityDateField.text
        
        var hourArray = hourString?.components(separatedBy: ":")
        
        var realHour: String = (hourArray?[0])!
        
        var realMinute: String = (hourArray?[1])!
        
        var totalMinute = 0
        
        var totalMeterTravelled = 0
        
        print(realHour)
        
        print(realMinute)
        
        if activityChosen == "tennis"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 2 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
        else if activityChosen == "basketball"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 2 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
        else if activityChosen == "swimming"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 2 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
        else if activityChosen == "volleyball"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 2 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
        else if activityChosen == "football"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 2 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
        else if activityChosen == "golf"{
            totalMinute = Int(realHour)! * 60 + Int(realMinute)!
            
            totalMeterTravelled = 1 * (totalMinute / 30)
            
            print(totalMeterTravelled)
        }
        
    }
    
    
    @IBAction func AddCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
