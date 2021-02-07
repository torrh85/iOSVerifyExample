//
//  FactorView.swift
//  iOSVerifyExample
//
//  Created by Hawer Alberto Torres Castañeda on 6/02/21.
//

import UIKit

class FactorView: BaseView {
    var viewModel: ChallengeViewModel
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Medium",size:12)
        label.text = "FACTOR INFORMATION"
        
        return label
    }()
    
    let sidLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let factorType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let factorStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue",size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let stackView: UIStackView = {
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
        setupStackView()
    }
    
    func setupStackView() {
        sidLabel.text = viewModel.dataSid
        date.text = viewModel.date
        factorStatus.text = viewModel.factorStatus
        factorType.text = viewModel.factorType
        
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(sidLabel)
        stackView.addArrangedSubview(date)
        stackView.addArrangedSubview(factorStatus)
        stackView.addArrangedSubview(factorType)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
             stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
             stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
             stackView.heightAnchor.constraint(equalToConstant: 90)])
    }

}
