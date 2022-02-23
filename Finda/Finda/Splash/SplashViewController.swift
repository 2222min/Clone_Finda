//
//  SplashViewController.swift
//  Finda
//
//  Created by mobile on 2022/02/22.
//

import ModernRIBs
import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import NSObject_Rx

protocol SplashPresentableListener: AnyObject {
  
}

final class SplashViewController: UIViewController, SplashPresentable, SplashViewControllable, UIScrollViewDelegate {

    weak var listener: SplashPresentableListener?
    
    let splashModel:  BehaviorRelay<[SplashModel]?> = .init(value: nil)
    
    // Paging CollectionView
    private let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init()
        layout.itemSize = .init(width: SCREENWIDTH, height: SCREENHEIGHT)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        $0.collectionViewLayout = layout
        $0.isPagingEnabled = true
        $0.backgroundColor = .clear
        $0.alwaysBounceHorizontal = true
        $0.showsHorizontalScrollIndicator = false
        $0.clipsToBounds = true
    }
    // pageControl
    private let pageControl = UIPageControl().then{
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .lightGray
        $0.currentPageIndicatorTintColor = .mainColor
    }
    
    // 본인인증 버튼
    private let authBtn = UIButton().then{
        $0.backgroundColor = .mainColor
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("본인인증하고 시작하기", for: .normal)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        configure()
        setupViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        setupViews()
        bind()
    }
    func configure() {
        // 카드뷰 컬렉션 뷰 Configuration
        collectionView.register(SplashCVC.self, forCellWithReuseIdentifier: "SplashCVC")
        collectionView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func setupViews() {
        
        view.addSubview(pageControl)
        view.addSubview(authBtn)
        view.addSubview(collectionView)
        
        pageControl.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(50)
        }
        authBtn.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(authBtn.snp.top)
        }
    }
    
    func bind() {
        
        // 컬렉션 뷰 데이터 바인딩
        splashModel.compactMap{ $0 }
        .observe(on: MainScheduler.instance)
        .bind(to: collectionView.rx.items(cellIdentifier: "SplashCVC", cellType: SplashCVC.self))
        { (_, element, cell) in
            
            cell.imageView.image = element.image
            
        }.disposed(by: rx.disposeBag)
        
        // 컬렉션 뷰 페이징
        collectionView.rx.willEndDragging
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                let page = Int($0.targetContentOffset.pointee.x / (self.collectionView.frame.width - layout.minimumLineSpacing))
                self.pageControl.currentPage = page
            }).disposed(by: rx.disposeBag)
    }
    
    func setCollectionView(_ splashModel: [SplashModel]) {
        self.splashModel.accept(splashModel)
    }
    
}
