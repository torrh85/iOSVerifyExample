//
//  LoginViewController.swift
//  iOSVerifyExample
//
//  Created by Hawer on 4/02/21.
//

import UIKit

class LoginViewController: BaseViewController {
    private var viewModel: LoginViewModel
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let textUser: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        return textField
    }()
    
    private let textPassword: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5.0
        
        return stackView
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.setTitle("", for: .disabled)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .blue
        
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStackView()
        setupSpinner()
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
    
    private func setupStackView() {
        stackView.addArrangedSubview(textUser)
        stackView.addArrangedSubview(textPassword)
        stackView.addArrangedSubview(logInButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
             stackView.heightAnchor.constraint(equalToConstant: 100)])
        
        logInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc func loginAction(){
        spinner.startAnimating()
        let name = textUser.text ?? ""
        let password = textPassword.text ?? ""
        let user = User(name: name.lowercased(), password: password)
        
        viewModel.login(user) { result in
            DispatchQueue.main.async { self.spinner.stopAnimating() }
            switch result {
                case .success(let identity): self.presentFactorViewController(identity)
                case .failure(let error): self.presentAlert(error)
            }
        }
    }
    
    private func presentFactorViewController(_ identity: Identity) {
        DispatchQueue.main.async {
            let factorViewModel = FactorViewModel(identity: identity)
            let factorViewController = FactorViewController(viewModel: factorViewModel)
            factorViewController.modalPresentationStyle = .fullScreen
            
            self.present(factorViewController, animated: true, completion: nil)
        }
    }
    
    private func presentAlert(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Authentication error!",
                                          message: "Unable to authenticate",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
