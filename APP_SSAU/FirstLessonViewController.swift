//
//  FirstLessonViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 08.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class FirstLessonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableItems: UITableView!
    //var rasp = Rasp()
    var raspDay: Day?
    var array: [String] = [" ","Сиспро", "Тервер", " ", "Физ-ра"]
    var arrayTime: [String] = ["08:00 - 09:35",
                               "09:45 - 11:20",
                               "11:30 - 13:05",
                               "13:30 - 15:05",
                               "15:15 - 16:50",
                               "17:00 - 18:35",
                               "18:45 - 20:15",
                               "20:25 - 21:55"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*DownloadJSON {
            self.tableItems.reloadData()
        }*/
        tableItems.delegate = self
        tableItems.dataSource = self
        //минус полосочки
        tableItems.tableFooterView = UIView()
    }
    /*func DownloadJSON(completed: @escaping() -> ()){
        let url = URL( string: "http://localhost:4567/getTimeTable?my_id=1&token=1")
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            guard let data = data else{ return }
            do{
                let decoder = JSONDecoder()
                self.rasp = try decoder.decode(Rasp.self, from: data)
                print(self.rasp.time)
                print(self.rasp.weeks[0].days[0].couple[1]?.allGroup?.discipline)
                //print(self.rasp.weeks[0].days[0].couple[1]?.allGroup?.discipline)
                DispatchQueue.main.async {
                    completed()
                }
            } catch let jsonErr{
                print("error", jsonErr)
            }
            }.resume()
    }*/
    
    //MARK - UIViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableItems.dequeueReusableCell(withIdentifier: "FirstLessonItemCell") as! FirstLessonItemCell
        var item = array[indexPath.row]
       // var itemTime = self.rasp.time[indexPath.row]
        
        // вот сюда забиваем все из джсон:
        cell.labelTime.text = arrayTime[indexPath.row]
        if raspDay?.couple[indexPath.row]?.bySubgroups == false {
            cell.labelDiscipline.text = raspDay?.couple[indexPath.row]?.allGroup?.discipline
        }
        
            
       // cell.labelTime.text = itemTime
        //cell.labelDiscipline.text = item
        //rasp1[indexPath.row].weeks?[indexPath.row].days?[indexPath.row].couple?[indexPath.row].all_group?.discipline //"ну здесь название предмета"
        cell.labelType.text = "ну здесь тип "
        cell.labelTeacher.text = "ну здесь фио препода"
        
        return cell
    }
   
    //MARK - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // выделение ячейки  при нажатии
        //переход на другой экран
       var item = array[indexPath.row]
        //переход по segue
        self.performSegue(withIdentifier: "FirstLessonToNotepad", sender: item)
        //убрать выделение
        tableItems.deselectRow(at: indexPath, animated: true)
    }
    //MARK: Data send
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //куда мы направляемся
        if let controller =  segue.destination as? UIViewController{//ui потом поменять на то, куда хотим
            controller.title = sender as? String
        }
    }
    
}
