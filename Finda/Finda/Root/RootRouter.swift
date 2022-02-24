//
//  RootRouter.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs

protocol RootInteractable: Interactable, SplashListener{
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func addChildVC(_ viewcontroller: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>{

    private let appSplash: SplashBuildable
    private var appRouting: ViewableRouting?
    
    init(
         interactor: RootInteractable,
         viewController: RootViewControllable,
         appSplash: SplashBuildable
    ) {
        self.appSplash = appSplash
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        if appRouting != nil {
            return
        }
        let splashRouter = appSplash.build(withListener: interactor)
        self.appRouting = splashRouter
        
        attachChild(splashRouter)
        
        let navi = NavigationControllerable.init(root: splashRouter.viewControllable)
        viewController.addChildVC(navi)
        
    }
}

extension RootRouter: RootRouting {
   
}
