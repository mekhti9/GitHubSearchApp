//
//  GFFollowersItemVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 06.02.2024.
//

import UIKit

class GFFollowersItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        iteminfoViewOne.set(iteminfoType: .followers, count: user.followers)
        iteminfoViewTwo.set(iteminfoType: .following, count: user.following)
        actionButton.set(backgroundColor: .systemBlue, title: "get \(user.login)s folowers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
