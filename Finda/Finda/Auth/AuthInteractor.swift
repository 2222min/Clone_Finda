//
//  AuthInteractor.swift
//  Finda
//
//  Created by mobile on 2022/02/24.
//

import ModernRIBs

protocol AuthRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AuthPresentable: Presentable {
    var listener: AuthPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AuthListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func detachEvent()
}

final class AuthInteractor: PresentableInteractor<AuthPresentable>, AuthInteractable {

    weak var router: AuthRouting?
    weak var listener: AuthListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AuthPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
}
extension AuthInteractor: AuthPresentableListener {
    func moveToPreVC() {
        self.listener?.detachEvent()
    }
}
