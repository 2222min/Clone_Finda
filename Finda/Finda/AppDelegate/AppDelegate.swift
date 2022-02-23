//
//  AppDelegate.swift
//  Finda
//
//  Created by mobile on 2022/02/18.
//

import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        
        let result = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = result
        
        window.rootViewController = result.viewControllable.uiviewController
        window.makeKeyAndVisible()
        
        launchRouter?.launch(from: window)
        
        return true
    }


}

