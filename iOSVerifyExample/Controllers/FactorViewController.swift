//
//  FactorViewController.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit
import TwilioVerify

class FactorViewController: BaseViewController {
    private var viewModel: FactorViewModel

    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let factorButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Create factor", for: .normal)
        button.setTitle("", for: .disabled)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .blue
        
        return button
    }()
    
    init(viewModel: FactorViewModel) {
        self.viewModel = viewModel
        super.init()
        
        setupCreateFactorButton()
        setupSpinner()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate(
            [spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
             spinner.heightAnchor.constraint(equalToConstant: 37),
             spinner.heightAnchor.constraint(equalToConstant: 37)])
    }
    
    private func setupCreateFactorButton() {
        factorButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(factorButton)
        
        NSLayoutConstraint.activate(
            [factorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             factorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
             factorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
             factorButton.heightAnchor.constraint(equalToConstant: 40)])
        
        factorButton.addTarget(self, action: #selector(createFactor), for: .touchUpInside)
    }
    
    @objc func createFactor() {
        spinner.startAnimating()
        viewModel.fetchAccessToken { result in
            DispatchQueue.main.async { self.spinner.stopAnimating() }
            switch result {
                case .success(let factor): self.presentChallenges(toFactor: factor)
                case .failure(let error): self.presentAlert(error)
            }
        }
    }
    
    private func presentChallenges(toFactor factor: Factor) {
        DispatchQueue.main.async {
            let challengeViewModel = ChallengeViewModel(factor: factor)
            let challengeViewController = ChallengeViewController(viewModel: challengeViewModel)
            challengeViewController.modalPresentationStyle = .fullScreen
            
            self.present(challengeViewController, animated: true, completion: nil)
        }
    }
    
    private func presentAlert(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!",
                                          message: "\(error.localizedDescription)",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
