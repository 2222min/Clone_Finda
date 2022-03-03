//
//  InputNameView.swift
//  Finda
//
//  Created by mobile on 2022/03/03.
//

import UIKit

class InputNameView: UIView {
    
    
    private let titleLable = UILabel().then{
        $0.text = "이름"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    private let nameTF = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.borderStyle = .none
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func setupViews(){
        self.addSubview(titleLable)
        self.addSubview(nameTF)
        
        titleLable.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(15)
        }
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
