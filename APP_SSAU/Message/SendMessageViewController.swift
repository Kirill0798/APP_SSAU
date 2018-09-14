//
//  SendMessageViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 25.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController {

    @IBAction func sendMessage(_ sender: Any) {
        if (newMessage.text != nil) && newMessage.text != "" {
            //  todoList?.append(textField.text!)
            addMessage(newMes:"\(newMessage.text!)")
           
        }
    }
    @IBOutlet weak var newMessage: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func addMessage(newMes: String){
        let encodedText = newMes.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let myString = "http://192.168.43.113:4567/sendMessage?recipients=\(UserDefaults.standard.string(forKey: "studyGroup")!)&body=\(encodedText!)&token=\(UserDefaults.standard.string(forKey: "token")!)"
        print(myString)
        guard let url = URL(string: myString) else {return}
        URLSession.shared.dataTask(with: url){(data, response, err) in
            guard let data = data else { return }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                if response != nil {
                    do{
                        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
                        print(serverResponse.response)
                        Toast.long(message: "\((serverResponse.response)!)", success: "1", failer: "0")
                        
                    }catch{}
                    
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
            }.resume()
    }

   
}
