//
//  MainTabController.swift
//  Twittor
//
//  Created by Simon Peter Ojok on 21/09/2022.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(handleActionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleActionButtonTapped() {
        print("123 - Button Clicked")
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 64,
            paddingRight: 16,
            width: 56,
            height: 56
        )
        actionButton.layer.cornerRadius = 56 / 2
    }
    
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
