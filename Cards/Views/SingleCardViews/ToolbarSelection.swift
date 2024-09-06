//
//  ToolbarSelection.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
    var id: Int {
        hashValue
    }
    
    case photoModal, frameModal, stickerModal, textModal
}


