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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.moveToPreVC()
    }
}
