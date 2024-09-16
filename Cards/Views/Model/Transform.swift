//
//  Transform.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI


struct Transform {
    var size = CGSize(
        width: Settings.defaultElementSize.width,
        height: Settings.defaultElementSize.height)
    var rotation: Angle = .zero
    var offset: CGSize = .zero
}

extension Transform: Codable {}
