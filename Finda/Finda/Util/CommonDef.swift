//
//  CommonDef.swift
//  Finda
//
//  Created by mobile on 2022/02/23.
//

import UIKit
import SnapKit

let SCREENHEIGHT = UIScreen.main.bounds.size.height
let SCREENWIDTH = UIScreen.main.bounds.size.width

let window = UIApplication.shared.connectedScenes
    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    .first { $0.isKeyWindow }
let topPadding = window?.safeAreaInsets.top
let bottomPadding = window?.safeAreaInsets.bottom
let guideLineHeigth = SCREENHEIGHT - topPadding! - bottomPadding!
