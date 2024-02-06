//
//  GFItemInfoVC.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 06.02.2024.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let iteminfoViewOne = GFItemInfoView()
    let iteminfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
    }
    
    func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.co
        ])
    }

}
