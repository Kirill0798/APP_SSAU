//
//  FirstWeekViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 08.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class FirstWeekViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableItems: UITableView!
    
     var rasp = Rasp()
   // var array: [String:Int] = ["Понедельник":0, "Вторник":1, "Среда":2,  "Четверг":3,"Пятница":4,"Суббота":5]

    var array: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableItems.dequeueReusableCell(withIdentifier: "FirstDayItemCell") as! FirstDayItemCell
        var item = array[indexPath.row]
        cell.labelDay.text = item
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FirstDayToLesson", sender: tableItems.indexPathForSelectedRow)//self)
        //tableItems.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FirstLessonViewController{
            //print((tableItems.indexPathForSelectedRow?.row)! as Any)
            //print(array[(tableItems.indexPathForSelectedRow?.row)!])
            //print((tableItems.indexPathForSelectedRow?.row))
            //controller.raspDay = rasp.weeks[0].days[(tableItems.indexPathForSelectedRow?.row)!]
           // controller.raspDay = tableItems.indexPathForSelectedRow?.row as? Day
        }
    }
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL( string: "http://localhost:4567/getTimeTable?&t")
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.rasp = try decoder.decode(Rasp.self, from: data)
                print(self.rasp.time)
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
