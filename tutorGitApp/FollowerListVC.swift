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
        navigationController?.isNavigationBarHidden = false 
    }
}
