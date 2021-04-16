//
//  TabBarViewController.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [mainViewController, mainViewController2]
    }

    lazy var mainViewController: MainViewController = {
        let vc = MainViewController()
        
        let image = UIImage(systemName: "circle")
        
        let tabItem = UITabBarItem(title: "main", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
    
    lazy var mainViewController2: MainViewController = {
        let vc = MainViewController()
        
        let image = UIImage(systemName: "square")
        
        let tabItem = UITabBarItem(title: "main", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected: \(viewController)")
    }
}
