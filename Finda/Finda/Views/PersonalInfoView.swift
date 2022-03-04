//
//  PersonalInfoView.swift
//  Finda
//
//  Created by mobile on 2022/03/04.
//

import UIKit

class PersonalInfoView: UIView {

    private let titleLable = UILabel().then{
        $0.text = "주민등록번호"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    public let nameTF = UITextField().then{
        $0.textColor = .black
        $0.placeholder = "이름 입력"
        $0.autocapitalizationType = .none
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.borderStyle = .none
    }
    private let underline = UIView().then {
        $0.backgroundColor = .lightGray
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        bind()
    }
    
    func setupViews(){
        self.addSubview(titleLable)
        self.addSubview(nameTF)
        self.addSubview(underline)
        
        titleLable.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(15)
        }
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        underline.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func bind() {
        
        nameTF.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.titleLable.textColor = .mainColor
                self.underline.backgroundColor = .mainColor
            }).disposed(by: rx.disposeBag)
    }

}
