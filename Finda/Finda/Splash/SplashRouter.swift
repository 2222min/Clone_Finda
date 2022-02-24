//
//  SplashRouter.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs

protocol SplashInteractable: Interactable, AuthListener {
    var router: SplashRouting? { get set }
    var listener: SplashListener? { get set }
}

protocol SplashViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SplashRouter: ViewableRouter<SplashInteractable, SplashViewControllable> {
   
    

    private let appAuth: AuthBuildable
    private var appRouting: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SplashInteractable,
                  viewController: SplashViewControllable,
         appAuth: AuthBuildable
                  
    ) {
        self.appAuth = appAuth
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension SplashRouter: SplashRouting {
    // Move To Auth Page
    func moveToAuthPage() {
        if appRouting != nil {
            return
        }

        let authRouter = appAuth.build(withListener: interactor)
        self.appRouting = authRouter
        
        attachChild(authRouter)
        self.viewController.pushViewController(authRouter.viewControllable, animated: true)
    }
    
    // Detach Auth
    func detachAuth() {
        if let authRouting = appRouting as? AuthRouting {
            detachChild(authRouting)
            appRouting = nil
        }
    }
}
