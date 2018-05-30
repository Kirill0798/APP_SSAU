//
//  AddController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 13.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    var myLesson:String?
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    func addNote(newNote:String){
        let encodedTextsNote = newNote.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        let encodedTextsLesson = myLesson?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let myString: String = "http://25.54.246.29:4567/addNote?token=fe059be107aa357b5d6d19829a4a6953&lesson=\(encodedTextsLesson!)&text=\(encodedTextsNote!)"
        print(encodedTextsNote!)
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
