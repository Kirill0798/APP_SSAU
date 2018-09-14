//
//  AddController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 13.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    var dateForUrl: String!
    var myLesson:String?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dpText: UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month =  calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let todayDate:String = "\(day)/\(month)/\(year)"
          dateForUrl = todayDate
//        if month < 10{
////        let todayDate:String = "\(day)/\(month)/\(year)"
//            let todayDate: String = "\(day)/"+"0"+"\(month)/"+"\(year)"
//             dateForUrl = todayDate
//        } else{
//            let todayDate:String = "\(day)/\(month)/\(year)"
//             dateForUrl = todayDate
//        }
       
        print("\(day)/\(month)/\(year)")
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
    }

    @IBAction func addPressed(_ sender: UIButton) {
        if (textField.text != nil) && textField.text != "" {
          //  todoList?.append(textField.text!)
            addNote(newNote:"\(textField.text!)")
            textField.text = ""
            textField.placeholder = "Добавить ещё?"
        }
    }
    func createDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        self.datePicker.locale = Locale(identifier: "Rus")
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dpText.inputAccessoryView = toolbar
        dpText.inputView = datePicker
        
    }
    @objc func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/YYYY"
        print(dateFormatter.string(from: datePicker.date))
        dpText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }

    func addNote(newNote:String){
        let encodedTextsNote = newNote.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        let encodedTextsLesson = myLesson?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let myString: String = "http://192.168.43.113:4567/addNote?token=\(UserDefaults.standard.string(forKey: "token")!)&lesson=\(encodedTextsLesson!)&text=\(encodedTextsNote!)&start=\(dateForUrl!)&deadline=\(dpText.text!)"
        print(encodedTextsNote!)
        print(myString)
        let url = URL(string: myString)
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            guard let data = data else { return }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                if response != nil {
                    do{
                        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)                        
                        Toast.long(message: "\((serverResponse.response)!)", success: "1", failer: "0")
                        
                        }catch{}
                    
                    }
                } catch let jsonErr{
                print("error", jsonErr)
            }
        }.resume()
    }
    
}
