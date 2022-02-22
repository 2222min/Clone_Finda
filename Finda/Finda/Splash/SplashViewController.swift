//
//  SplashViewController.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs
import UIKit
import Then
import SnapKit

protocol SplashPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SplashViewController: UIViewController, SplashPresentable, SplashViewControllable {

    weak var listener: SplashPresentableListener?
    
    let label = UILabel().then{
        $0.text = "Splash"
        $0.textColor = .black
        $0.textAlignment = .center
    }
    init(){
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
