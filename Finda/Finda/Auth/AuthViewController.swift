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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.moveToPreVC()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
    }
}
