//
//  ViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 08.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

 class ViewController: UIViewController {
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBAction func enter(_ sender: Any) {
    }
    var user:[User]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        user = CoreDataHandler.fetchObject()
//        if user![0].login != nil && user![0].password != nil{
//            loginLabel.text = "\(user![0].login!)"
//            passwordLabel.text = "\(user![0].password!)"
//        }
        print(user![0].login)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

