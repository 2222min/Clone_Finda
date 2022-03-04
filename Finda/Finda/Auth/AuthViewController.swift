//
//  AuthViewController.swift
//  Finda
//
//  Created by mobile on 2022/02/24.
//

import ModernRIBs
import RxSwift
import RxCocoa
import RxKeyboard
import NSObject_Rx
import UIKit

protocol AuthPresentableListener: AnyObject {
    func moveToPreVC()
}

final class AuthViewController: UIViewController, AuthPresentable, AuthViewControllable {

    weak var listener: AuthPresentableListener?
    private let inputType: BehaviorRelay<InputType> = .init(value: .name)
    
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
    
    private let nextBtn = UIButton().then {
        $0.backgroundColor = . systemBlue
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.isHidden = true
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.moveToPreVC()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLable)
        self.view.addSubview(stackView)
        self.view.addSubview(nextBtn)
        
        self.stackView.addArrangedSubview(nameView)
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        // 다음 버튼 View
        nextBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    private func bind() {
        
        nextBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                if self.nameView.nameTF.text == "" {
                    return
                } else {
                    self.inputType.accept(.rrn)
                }
            }).disposed(by: rx.disposeBag)
        
        inputType.subscribe(onNext:{ [weak self] type in
            guard let self = self else { return }
            switch type {
            case .rrn:
                self.addInStackView(self.personalInfoView)
                self.nextBtn.isHidden = true
//            case .agency:
//
//            case .phoneNum:
                
            default: break
           
            }
            
        }).disposed(by: rx.disposeBag)
        
        
        // 키보드 노출 시 Constraints 조정
        RxKeyboard.instance.willShowVisibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let self = self else { return }
                if self.inputType.value == .name {
                    UIView.animate(withDuration: 0) {
                        self.nextBtn.snp.updateConstraints { make in
                            make.bottom.equalToSuperview().offset(-keyboardVisibleHeight)
                        }
                        self.nextBtn.isHidden = false
                    }
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    private func addInStackView(_ view: UIView){
            self.stackView.snp.updateConstraints{ make in
                make.height.equalTo((self.stackView.subviews.count+1) * 50 + self.stackView.subviews.count * 10)
            }
        self.stackView.insertArrangedSubview(view, at: 0)
        
    }
    
}

enum InputType {
    case name // 이름
    case rrn // 주민등록번호
    case agency // 통신사
    case phoneNum // 휴대폰 번호
}
