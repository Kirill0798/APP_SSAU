//
//  ViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 08.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//192.168.43.201

import UIKit

 class ViewController: UIViewController {
    var student = Student()
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBAction func enter(_ sender: Any) {
        if (loginLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)!{
            displayMyAlertMes(userMessage: "Проверьте: заполнены ли все поля")
        } else{
            downloadJSON {
                print("ok")
                UserDefaults.standard.set(self.student.login, forKey: "login")
                UserDefaults.standard.set(self.student.password, forKey: "password")
                UserDefaults.standard.set(self.student.gender, forKey: "gender")
                UserDefaults.standard.set(self.student.birthday, forKey: "birthday")
                UserDefaults.standard.set(self.student.groupManager, forKey: "groupManager")
                UserDefaults.standard.set(self.student.groupProforg, forKey: "groupProforg")
                UserDefaults.standard.set(self.student.groupPresident, forKey: "groupPresident")
                UserDefaults.standard.set(self.student.token, forKey: "token")
                print("\(self.student.token)    ВОТ ЗДЕСЬ ЛЕЖАТ  \(UserDefaults.standard.string(forKey: "token"))")
                UserDefaults.standard.set(self.student.firstName, forKey: "firstName")
                UserDefaults.standard.set(self.student.middleName, forKey: "middleName")
                UserDefaults.standard.set(self.student.lastName, forKey: "lastName")
                UserDefaults.standard.set(self.student.phoneNumber, forKey: "phoneNumber")
                UserDefaults.standard.set(self.student.group.number, forKey: "studyGroup")
                UserDefaults.standard.synchronize()
                
                
                UserDefaults.standard.set(true, forKey: "isUserLogin")
                print("\(UserDefaults.standard.bool(forKey: "isUserLogin"))")
                let myAlert = UIAlertController(title: "Alert", message: "Авторизация прошла успешно", preferredStyle: .alert)
                let okAction = UIAlertAction(title:"oк", style: .default){ action in
                    self.dismiss(animated: true, completion: nil)
                }
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                
                let loginStored = UserDefaults.standard.string(forKey: "login")
                let passwordStored = UserDefaults.standard.string(forKey: "password")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func displayMyAlertMes(userMessage: String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "oк", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    func downloadJSON(completed: @escaping () -> ()){
        
        
        let myString: String = "http://192.168.43.113:4567/authorize?login=\(loginLabel.text!)&password=\(passwordLabel.text!)"
        print(myString)
        
        guard let url = URL(string: myString) else {
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, err) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.student = try decoder.decode(Student.self, from: data)
                print(self.student)
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
            }.resume()
        
        
        
//        let myAlert = UIAlertController(title: "Alert", message: "Авторизация прошла успешно", preferredStyle: .alert)
//        let okAction = UIAlertAction(title:"oк", style: .default){ action in
//            self.dismiss(animated: true, completion: nil)
//        }
//        myAlert.addAction(okAction)
//        self.present(myAlert, animated: true, completion: nil)
        
    }
    


}

