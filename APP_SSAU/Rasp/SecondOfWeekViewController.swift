//
//  SecondOfWeekViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 22.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class SecondOfWeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var rasp2 = Rasp()
    var array: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadJSON {
            self.tableView.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = array[indexPath.row]
        performSegue(withIdentifier: "from2WeekToDay", sender: item)//self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LessonsViewController{
            print(tableView.indexPathForSelectedRow!.row)
            print(rasp2.weeks[1].days[(tableView.indexPathForSelectedRow?.row)!])
            destination.raspDay = rasp2.weeks[1].days[(tableView.indexPathForSelectedRow?.row)!]
            destination.title = sender as? String
            print(rasp2.weeks[1].days[(tableView.indexPathForSelectedRow?.row)!])
            // print(rasp.weeks[0].days[(self.tableView.indexPathForSelectedRow?.row)!])
        }
    }
    func downloadJSON(completed: @escaping () -> ()){
        guard let url = URL( string: "http://192.168.43.113:4567/getTimeTable?token=\((UserDefaults.standard.string(forKey: "token"))!)") else {return}
        URLSession.shared.dataTask(with: url){(data, response, err) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.rasp2 = try decoder.decode(Rasp.self, from: data)
                print(self.rasp2.time)
                //print(self.rasp.weeks[0].days[0].couple[1]?.allGroup?.discipline)
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
            }.resume()
    }
}
