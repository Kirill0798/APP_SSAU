//
//  RaspPageViewController.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 22.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class RaspPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var subViewController:[UIViewController] = {
        return[
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstOfWeekViewController") as! FirstOfWeekViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondOfWeekViewController") as! SecondOfWeekViewController
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewController[0]], direction: .forward, animated: true, completion: nil)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return subViewController[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return subViewController[1]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
