//
//  RootViewController.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs
import UIKit
import Then
import SnapKit

protocol RootPresentableListener: AnyObject {
   
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    let mainView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func addChildVC(_ viewcontroller: ViewControllable) {
        let viewController = viewcontroller.uiviewController
        let subView = viewController.view
        addChild(viewController)
        self.mainView.addSubview(subView!)
        
        subView?.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        viewController.didMove(toParent: self)
    }
    
}
