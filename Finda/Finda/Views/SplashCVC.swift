//
//  SplashCVC.swift
//  Finda
//
//  Created by mobile on 2022/02/23.
//

import UIKit
import Then
import SnapKit

class SplashCVC: UICollectionViewCell {
    
    let imageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews(){
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
