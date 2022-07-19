//
//  MainTabViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 19.07.22.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.barStyle = .default
        tabBar.tintColor = .label
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemBlue
        
        let vc1 = MainNavigationViewController()
        
        vc1.tabBarItem.title = "First"
        vc1.tabBarItem.image = UIImage(named: "apple")
        
        let vc2 = SecondNavigationViewController()
        
        vc2.tabBarItem.title = "Second"
        vc2.tabBarItem.image = UIImage(named: "news")
        
        self.setViewControllers([vc1, vc2], animated: false)
        
        self.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
