//
//  LessonsViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 20.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var raspDay : Day?
    
    var myArray: [String] = []
    var arrayTime: [String] = ["08:00 09:35",
                               "09:45 11:20",
                               "11:30 13:05",
                               "13:30 15:05",
                               "15:15 16:50",
                               "17:00 18:35",
                               "18:45 20:15",
                               "20:25 21:55"]
    @IBOutlet weak var tableItems: UITableView!
    lazy var refresher: UIRefreshControl = {
        let refresherControl = UIRefreshControl()
        refresherControl.tintColor = .white
        refresherControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refresherControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableItems.delegate = self
        tableItems.dataSource = self
        self.tableItems.reloadData()
        
    }
    @objc
    func requestData(){
        print("requesting data")
        let deadline = DispatchTime.now() + .milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.refresher.endRefreshing()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableItems.dequeueReusableCell(withIdentifier: "LessonTableViewCell") as! LessonTableViewCell
        cell.timeLabel.text = arrayTime[indexPath.row]
        
        if ((raspDay?.couple[indexPath.row]?.allGroup) != nil) {
            cell.disciplineLabel.text = raspDay?.couple[indexPath.row]?.allGroup?.discipline
            if (raspDay?.couple[indexPath.row]?.allGroup?.teacher.firstName) != nil{
            cell.teacherLabel.text = "\((raspDay?.couple[indexPath.row]?.allGroup?.teacher.firstName)!) \((raspDay?.couple[indexPath.row]?.allGroup?.teacher.middleName)!) \((raspDay?.couple[indexPath.row]?.allGroup?.teacher.lastName)!)"
            } else{
                cell.teacherLabel.text = " "
            }
        } else{
            if (raspDay?.couple[indexPath.row]?.firstSubgroup) != nil{
                cell.disciplineLabel.text = raspDay?.couple[indexPath.row]?.firstSubgroup?.discipline
                cell.teacherLabel.text = "\((raspDay?.couple[indexPath.row]?.firstSubgroup?.teacher.firstName)!) \((raspDay?.couple[indexPath.row]?.firstSubgroup?.teacher.middleName)!) \((raspDay?.couple[indexPath.row]?.firstSubgroup?.teacher.lastName)!)"
            }else{
                cell.disciplineLabel.text = " "
                cell.teacherLabel.text = " "
            }
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var lessonItem = raspDay?.couple[indexPath.row]?.allGroup?.discipline
        performSegue(withIdentifier: "LessonToNotepad", sender: lessonItem)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NotepadController{
            destination.title = sender as? String
            destination.disciplineNote = raspDay?.couple[(tableItems.indexPathForSelectedRow!.row)]?.allGroup?.discipline
        }
    }
    
}
