//
//  ViewController.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 23.04.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        
        vc1.title = "Home"
        vc2.title = "Upcoming"

        tabBar.tintColor = .label
        setViewControllers([vc1, vc2], animated: true)


    }
    
}

