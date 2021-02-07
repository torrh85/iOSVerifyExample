//
//  ChallengeViewController.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit

class ChallengeViewController: BaseViewController {
    private var viewModel: ChallengeViewModel
    
    private var factorView: FactorView!
    private var challengeView: ChallengeView!
    
    init(viewModel: ChallengeViewModel) {
        self.viewModel = viewModel
        super.init()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            viewModel.searchChallenge { challenge in
                if let challenge = challenge {
                    
                    DispatchQueue.main.async {
                        self.viewModel.challenge = challenge
                        self.challengeView.updateContent(challenge)
                    }
                    
                    timer.invalidate()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("Breadcrumb: Loading challenge view controller")
        
        setupFactorView()
        setupChallengeView()
        
        viewModel.registerDevice()
    }
    
    private func setupFactorView() {
        factorView = FactorView(viewModel: viewModel)
        factorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(factorView)
        
        NSLayoutConstraint.activate(
            [factorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
             factorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
             factorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
             factorView.heightAnchor.constraint(equalToConstant: 170)])
        
    }
    
    private func setupChallengeView() {
        challengeView = ChallengeView(viewModel: viewModel)
        challengeView.translatesAutoresizingMaskIntoConstraints = false
        challengeView.isHidden = true
        view.addSubview(challengeView)
        
        NSLayoutConstraint.activate(
            [challengeView.topAnchor.constraint(equalTo: factorView.bottomAnchor, constant: 20),
             challengeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
             challengeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
             challengeView.heightAnchor.constraint(equalToConstant: 300)])
    }
}
