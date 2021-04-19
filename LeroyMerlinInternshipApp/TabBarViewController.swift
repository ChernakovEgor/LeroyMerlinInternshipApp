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
        self.viewControllers = [mainViewController, listViewController, shopViewController, profileViewController, cartViewController]
        tabBar.tintColor = Dimensions.color
    }

    lazy var mainViewController: MainViewController = {
        let vc = MainViewController()
        
        let image = UIImage(systemName: "magnifyingglass")
        
        
        let tabItem = UITabBarItem(title: "Главная", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
    
    lazy var listViewController: UIViewController = {
        let vc = UIViewController()
        
        let image = UIImage(systemName: "list.triangle")
        
        let tabItem = UITabBarItem(title: "Мой список", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
    
    lazy var shopViewController: UIViewController = {
        let vc = UIViewController()
        
        let image = UIImage(systemName: "mappin.and.ellipse")
        
        let tabItem = UITabBarItem(title: "Магазины", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
    
    lazy var profileViewController: UIViewController = {
        let vc = UIViewController()
        
        let image = UIImage(systemName: "face.smiling")
        
        let tabItem = UITabBarItem(title: "Профиль", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
    
    lazy var cartViewController: UIViewController = {
        let vc = UIViewController()
        
        let image = UIImage(systemName: "cart")
        
        let tabItem = UITabBarItem(title: "Корзина", image: image, selectedImage: image)
        
        vc.tabBarItem = tabItem
        
        return vc
    }()
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected: \(viewController)")
    }
}
