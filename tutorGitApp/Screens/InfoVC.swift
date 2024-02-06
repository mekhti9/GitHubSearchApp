//
//  InfoVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 15.01.2024.
//

import UIKit

protocol InfoVCDelegate {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class InfoVC: UIViewController {
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureVC()
        networkCall()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func networkCall() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "sum went wrong my beautiful nigga", message: error.rawValue, button: "ok")
            }
        }
        print(username ?? "some nigga")
    }
    
    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVc = GFFollowersItemVC(user: user)
        followerItemVc.delegate = self
        
        self.add(childController: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childController: repoItemVC, to: self.itemViewOne)
        self.add(childController: followerItemVc, to: self.itemViewTwo)
        self.dateLabel.text = "bro was born \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for ItemView in itemViews {
            view.addSubview(ItemView)
            ItemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            itemViewOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 40),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 30),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childController: UIViewController, to containerView: UIView) {
        addChild(childController)
        containerView.addSubview(childController.view)
        childController.view.frame = containerView.bounds
        childController.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension InfoVC: InfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { 
            presentGFAlertOnMainThread(title: "invalid request", message: "url error", button: "bomboclat")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "no followers", message: "go and follow that nigga", button: "ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
