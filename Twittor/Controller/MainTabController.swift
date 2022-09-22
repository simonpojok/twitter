//
//  MainTabController.swift
//  Twittor
//
//  Created by Simon Peter Ojok on 21/09/2022.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNavigationController(
            image: UIImage(named: "home_unselected"),
            rootViewController: feed
        )
        
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(
            image: UIImage(named: "search_unselected"),
            rootViewController: explore
        )
        
        let notification = NotificationsController()
        let nav3 = templateNavigationController(
            image: UIImage(named: "like_unselected"),
            rootViewController: notification
        )
        
        let conversation = ConversationController()
        let nav4 = templateNavigationController(
            image: UIImage(named: "ic_mail_outline_white_2x-1"),
            rootViewController: conversation
        )
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
