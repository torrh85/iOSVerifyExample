//
//  ChallengeView.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit
import TwilioVerify

class ChallengeView : BaseView {
    var viewModel: ChallengeViewModel
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Medium",size:12)
        label.text = "CHALLENGE INFORMATION"
        
        return label
    }()
    
    private let message: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let date: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let expirationDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let approveButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Approve", for: .normal)
            button.setTitle("", for: .disabled)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.backgroundColor = .blue
            
            return button
    }()
    
    private let denyButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Deny", for: .normal)
            button.setTitle("", for: .disabled)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.backgroundColor = .blue
            
            return button
    }()
    
    private let containerButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5.0
        
        return stackView
    }()
    
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5.0
        
        return stackView
    }()
    
    init(frame: CGRect = .zero, viewModel: ChallengeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    override func didMoveToWindow() {
        renderContainerView()
    }
    
    private func renderContainerView() {
        containerButtons.addArrangedSubview(approveButton)
        containerButtons.addArrangedSubview(denyButton)
        
        containerView.addArrangedSubview(title)
        containerView.addArrangedSubview(message)
        containerView.addArrangedSubview(date)
        containerView.addArrangedSubview(expirationDate)
        containerView.addArrangedSubview(status)
        containerView.addArrangedSubview(containerButtons)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate(
            [containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
             containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
             containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
             containerView.heightAnchor.constraint(equalToConstant: 150)])

        approveButton.addTarget(self, action: #selector(approve), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(deny), for: .touchUpInside)
        
    }
    
    public func updateContent(_ challenge: Challenge) {
        self.viewModel.challenge = challenge
        
        isHidden = false
        message.text = viewModel.challengeMessage
        date.text = viewModel.date
        expirationDate.text = viewModel.challengeExpirationDate
        status.text = viewModel.challengeStatus
    }
    
    @objc func approve(){
        viewModel.updateChallenge(approved: true) { error in
            DispatchQueue.main.async {
                self.isHidden = true
            }
        }
    }
    
    @objc func deny(){
        viewModel.updateChallenge(approved: false) { error in
            DispatchQueue.main.async {
                self.isHidden = true
            }
        }
    }
}
