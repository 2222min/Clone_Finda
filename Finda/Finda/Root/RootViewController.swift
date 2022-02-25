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
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews(){
    }
    
    func addChildVC(_ viewcontroller: ViewControllable) {
        
        let viewController = viewcontroller.uiviewController
        addChild(viewController)
        self.view.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        viewController.didMove(toParent: self)
    }
    
}
