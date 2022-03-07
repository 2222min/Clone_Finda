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
    // 주민등록번호 앞자리
    public let rrnTF_front = UITextField().then{
        $0.textColor = .black
        $0.autocapitalizationType = .none
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.borderStyle = .none
    }
    // 주민등록번호 뒷자리
    public let rrnTF_back = UITextField().then{
        $0.textColor = .black
        $0.autocapitalizationType = .none
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.borderStyle = .none
    }
    // 주민등록번호 앞자리 하단 바
    private let underline_front = UIView().then {
        $0.backgroundColor = .lightGray
    }
    // 주민등록번호 뒷자리 하단 바
    private let underline_back = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    // "-"
    private let seperateLine = UILabel().then {
        $0.backgroundColor = .clear
        $0.text = "-"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .medium)
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
        self.addSubview(rrnTF_front)
        self.addSubview(underline_front)
        self.addSubview(rrnTF_back)
        self.addSubview(seperateLine)
        self.addSubview(underline_back)
        
        titleLable.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(15)
        }
        rrnTF_front.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        }
        underline_front.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        }
        rrnTF_back.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        }
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.leading.equalTo(rrnTF_front.snp.trailing).offset(10)
            make.trailing.equalTo(rrnTF_back.snp.leading).offset(-10)
            make.bottom.equalToSuperview()
        }
        underline_back.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().dividedBy(2).offset(-30)
        }
        
        
    }
    
    func bind() {
        rrnTF_front.rx.text.orEmpty
            .subscribe(onNext:{ [weak self] text in
                guard let self = self else { return }
                if  text.count == 6 {
                    self.rrnTF_back.becomeFirstResponder()
                } else if text.count > 6  {
                    self.rrnTF_front.deleteBackward()
                }
            }).disposed(by: rx.disposeBag)
        
        rrnTF_front.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.titleLable.textColor = .mainColor
                self.underline_front.backgroundColor = .mainColor
            }).disposed(by: rx.disposeBag)
        
        rrnTF_back.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.underline_front.backgroundColor = .lightGray
                self.underline_back.backgroundColor = .mainColor
            }).disposed(by: rx.disposeBag)
        
    }
    
    func initView() {
        self.titleLable.textColor = .black
        self.underline_front.backgroundColor = .lightGray
        self.underline_back.backgroundColor = .lightGray
    }
    
}
