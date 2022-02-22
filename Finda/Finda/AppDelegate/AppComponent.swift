//
//  AppComponent.swift
//  Finda
//
//  Created by mobile on 2022/02/21.
//

import Foundation
import ModernRIBs

final class AppComponent: Component<EmptyComponent>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
