//
//  MessageViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 22.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var refresher: UIRefreshControl = {
        let refresherControl = UIRefreshControl()
        refresherControl.tintColor = .black
        refresherControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refresherControl
    }()
    var timer: Timer?
    var message = Message()
    @IBOutlet weak var mesTableView: UITableView!
    
    override func viewDidLoad() {
        downloadJSON {
            self.mesTableView.reloadData()
        }
        mesTableView.delegate = self
        mesTableView.dataSource = self
        super.viewDidLoad()
        mesTableView.refreshControl = refresher
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer!.tolerance = 5
        
    }
    
    override func viewDidDisappear(_ animated: Bool){
       self.timer!.invalidate()
        super.viewDidDisappear(animated)
    }
    @objc
    func update(){
        downloadJSON {
            self.mesTableView.reloadData()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.response.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = mesTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
        cell.pictureLabel.backgroundColor = UIColor.black
        cell.pictureLabel.layer.cornerRadius = 20
        cell.idLabel.text = message.response[indexPath.row].senderName
        cell.messageLabel.text = message.response[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = message.response[indexPath.row]
        performSegue(withIdentifier: "toFull", sender: item)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FullMessageViewController{
            destination.fullText = message.response[(mesTableView.indexPathForSelectedRow?.row)!].body
        }
    }
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL( string: "http://25.54.246.29:4567/getMessages?token=fe059be107aa357b5d6d19829a4a6953")
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                self.message = try decoder.decode(Message.self, from: data)
                print(self.message)
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
