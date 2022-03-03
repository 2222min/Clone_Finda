//
//  AuthViewController.swift
//  Finda
//
//  Created by mobile on 2022/02/24.
//

import ModernRIBs
import UIKit

protocol AuthPresentableListener: AnyObject {
    func moveToPreVC()
}

final class AuthViewController: UIViewController, AuthPresentable, AuthViewControllable {

    weak var listener: AuthPresentableListener?
    
    private let titleLable = UILabel().then{
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.text = "이름 입력"
    }
    private let stackView = UIStackView().then{
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let nameView = InputNameView()
    private let personalInfoView = UIView().then{
        $0.backgroundColor = .cyan
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        addInStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        addInStackView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.moveToPreVC()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLable)
        self.view.addSubview(stackView)
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(12)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        nameView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        personalInfoView.snp.makeConstraints{ make in
            make.height.equalTo(50)
        }
    }
    
    private func addInStackView(){
        stackView.addArrangedSubview(nameView)
            self.stackView.snp.updateConstraints{ make in
                make.height.equalTo(110)
            }
        self.stackView.insertArrangedSubview(self.personalInfoView, at: 0)
        
    }
}

