import UIKit
import ModernRIBs

final class NavigationControllerable: ViewControllable {

    var uiviewController: UIViewController { self.navigationController }
    let navigationController: UINavigationController

    public init(root: ViewControllable) {
        let navigation = UINavigationController(rootViewController: root.uiviewController)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let navigationBar = UINavigationBar()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//            appearance.backgroundColor = .customblueColor
            navigationBar.standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
        } else {
//            navigation.navigationBar.barTintColor = .customblueColor
//            navigation.view.backgroundColor = .customblueColor
            navigation.navigationBar.isTranslucent = false
            navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigation.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigation.navigationBar.shadowImage = UIImage()
        }
        // 네비게이션 바 색상 UIColor와 일치시키기
        UINavigationBar.appearance().isTranslucent = false
        navigation.navigationBar.tintColor = .white
        self.navigationController = navigation
    }
}

extension ViewControllable {

    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        self.uiviewController.present(viewControllable.uiviewController, animated: true, completion: completion)
    }

    func dismiss(completion: (() -> Void)?) {
        self.uiviewController.dismiss(animated: true, completion: completion)
    }

    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }

    func popViewController(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popViewController(animated: animated)
        }
    }

    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }

    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        } else {
            self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        }
    }
}
extension LaunchRouting {
    public func launch_yuTHM() {
        interactable.activate()
        load()
    }
}
