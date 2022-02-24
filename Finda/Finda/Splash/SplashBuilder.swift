//
//  SplashBuilder.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs

protocol SplashDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SplashComponent: Component<SplashDependency>, AuthDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SplashBuildable: Buildable {
    func build(withListener listener: SplashListener) -> SplashRouting
}

final class SplashBuilder: Builder<SplashDependency>, SplashBuildable {

    override init(dependency: SplashDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SplashListener) -> SplashRouting {
        let component = SplashComponent(dependency: dependency)
        let viewController = SplashViewController()
        let interactor = SplashInteractor(presenter: viewController,splashModel: .init())
        
        let appAuth = AuthBuilder.init(dependency: component)
        interactor.listener = listener
        
        return SplashRouter(interactor: interactor,
                            viewController: viewController,
                            appAuth: appAuth
        )
    }
}
