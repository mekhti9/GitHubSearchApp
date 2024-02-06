//
//  GFRepoItemVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 06.02.2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        iteminfoViewOne.set(iteminfoType: .repos, count: user.publicRepos)
        iteminfoViewTwo.set(iteminfoType: .gists, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "go to mfs GitHub")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
