//
//  NotepadController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 13.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class NotepadController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var user:[User]? = nil
    lazy var refresher: UIRefreshControl = {
        let refresherControl = UIRefreshControl()
        refresherControl.tintColor = .black
        refresherControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refresherControl
    }()
    var timer: Timer?
    var disciplineNote: String?
    var note = Note()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer!.tolerance = 5
    }
    override func viewDidDisappear(_ animated: Bool){
        self.timer!.invalidate()
    }
    @objc
    func update(){
        downloadJSON {
            self.tableView.reloadData()
        }
        
        
    }
    @objc
    func requestData(){
        print("requesting data")
        let deadline = DispatchTime.now() + .milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.refresher.endRefreshing()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let todo = todoList{
//            return todo.count
//        }
//        else{
//            return 0
//        }
        return note.response.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        if let todo = todoList {
//            cell.textLabel?.text = todo[indexPath.row]
//        }
        cell.textLabel?.text = note.response[indexPath.row].text
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            todoList?.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote"{
        if let destination = segue.destination as? AddController{
            destination.myLesson = disciplineNote
            }
        }
    }
    func downloadJSON(completed: @escaping() -> ()){
        print("http://192.168.43.89:4567/getNote?token=fe059be107aa357b5d6d19829a4a6953&lesson=\(disciplineNote!)")
        let encodedTexts = disciplineNote?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let myString: String = "http://25.54.246.29:4567/getNote?token=fe059be107aa357b5d6d19829a4a6953&lesson=\(encodedTexts!)"
        let url = URL(string: myString)
        URLSession.shared.dataTask(with: url!){(data,response,err) in
            guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                self.note = try decoder.decode(Note.self, from:data)
                print(self.note)
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
        }.resume()
    }
}
