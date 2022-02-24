//
//  AuthBuilder.swift
//  Finda
//
//  Created by mobile on 2022/02/24.
//

import ModernRIBs

protocol AuthDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AuthComponent: Component<AuthDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AuthBuildable: Buildable {
    func build(withListener listener: AuthListener) -> AuthRouting
}

final class AuthBuilder: Builder<AuthDependency>, AuthBuildable {

    override init(dependency: AuthDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AuthListener) -> AuthRouting {
        let component = AuthComponent(dependency: dependency)
        let viewController = AuthViewController()
        let interactor = AuthInteractor(presenter: viewController)
        interactor.listener = listener
        return AuthRouter(interactor: interactor, viewController: viewController)
    }
}
