//
//  RegistrationViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 27.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    var user:[User]? = nil
    var student = Student()
    @IBOutlet weak var yearD: UITextField!
    @IBOutlet weak var monthD: UITextField!
    @IBOutlet weak var dayD: UITextField!
    var myData: String = ""
    var myGender: String = ""
    var myGroupManager: Int32 = 0
    var myGroupPresident: Int32 = 0
    var myGroupProforg: Int32 = 0
    
    

    @IBAction func ready(_ sender: Any) {
        downloadJSON {
            print("ok")
        }
    }
    @IBOutlet weak var LoginLabel: UITextField!
    @IBOutlet weak var PasswordLabel: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var groupMen: UISegmentedControl!

    
    @IBAction func genderCh(_ sender: Any) {
        if gender.selectedSegmentIndex == 0 {
            myGender = "муж"
        } else if gender.selectedSegmentIndex == 1{
            myGender = "жен"
        }
    }
    @IBAction func groupMenCh(_ sender: Any) {
        if groupMen.selectedSegmentIndex == 0 {
            myGroupManager = 0
            
        } else if groupMen.selectedSegmentIndex == 1{
            myGroupManager = 0
            myGroupProforg = 0
            myGroupPresident = 1
        } else if groupMen.selectedSegmentIndex == 2{
            myGroupManager = 0
            myGroupProforg = 1
            myGroupPresident = 0
        } else if groupMen.selectedSegmentIndex  == 3{
            myGroupManager = 1
            myGroupProforg = 0
            myGroupPresident = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func downloadJSON(completed: @escaping () -> ()){
        var myBirthday: String = "\(yearD.text!)-\(monthD.text!)-\(dayD.text!)"
        let encMyGender = myGender.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
       print(encMyGender!)
        var myString: String = "http://192.168.43.89:4567/registration?type=student&gender=\(encMyGender!)&birthday=\(myBirthday)&group_proforg=\(myGroupProforg)&group_president=\(myGroupPresident)&group_manager=\(myGroupManager)&login=\(LoginLabel.text!)&password=\(PasswordLabel.text!)&phone_number=\(number.text!)"
         print(myString)
        let url = URL(string: myString)
       
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.student = try decoder.decode(Student.self, from: data)
                print(self.student)
                //print(self.rasp.weeks[0].days[0].couple[1]?.allGroup?.discipline)
               
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
            }.resume()
        if CoreDataHandler.saveHandleObject(login: self.student.login,
                                            password: self.student.password,
                                            gender: self.student.gender,
                                            birthday: self.student.birthday,
                                            groupManager: Int32(self.student.groupManager),
                                            groupProforg: Int32(self.student.groupProforg),
                                            groupPresident: Int32(self.student.groupPresident),
                                            token: self.student.token,
                                            firstName: self.student.firstName,
                                            middleName: self.student.middleName,
                                            lastName: self.student.firstName,
                                            phoneNumber: self.student.phoneNumber,
                                            studyGroup: self.student.group.number){
            self.user = CoreDataHandler.fetchObject()
            for i in self.user!{
                print(self.user)
                print("ВСЕ СОХРАНИЛОСЬ")
            }
        }
    }

}
