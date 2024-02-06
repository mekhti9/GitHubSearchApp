//
//  InfoVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 15.01.2024.
//

import UIKit

class InfoVC: UIViewController {
    
    var username: String!
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
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
                DispatchQueue.main.async {
                    print(user)
                    self.add(childController: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "sum went wrong my beautiful nigga", message: error.rawValue, button: "ok")
            }
        }
        print(username ?? "some nigga")
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for ItemView in itemViews {
            view.addSubview(ItemView)
            ItemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        itemViewOne.backgroundColor = .systemRed
        itemViewTwo.backgroundColor = .systemGreen
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            itemViewOne.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 40),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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
