//
//  FollowerListVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 06.01.2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username ?? "nil", page: 1) { followers, errorMessage in
            guard let followers = followers else {
                presentGFAlertOnMainThread(title: "ayayya niggaaa", message: errorMessage!, buttonTitle: "ok")
            }
            
            print("followers.count = \(followers.count)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
