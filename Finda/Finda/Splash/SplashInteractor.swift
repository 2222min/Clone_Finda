//
//  SplashInteractor.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs
import UIKit

protocol SplashRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SplashPresentable: Presentable {
    var listener: SplashPresentableListener? { get set }
    func setCollectionView(_ splashModel: [SplashModel])
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SplashListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SplashInteractor: PresentableInteractor<SplashPresentable>, SplashInteractable, SplashPresentableListener {

    weak var router: SplashRouting?
    weak var listener: SplashListener?
    var splashModel: [SplashModel]?
  
    init(presenter: SplashPresentable,
         splashModel: [SplashModel]
    ) {
        self.splashModel = [ SplashModel.init(image: (.splashFirst ?? .init())),
                             SplashModel.init(image: .splashSecond ?? .init()),
                             SplashModel.init(image: .splashThird  ?? .init())]
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        presenter.setCollectionView(self.splashModel ?? .init())
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
