//
//  Card.swift
//  Cards
//
//  Created by Manu on 07/09/24.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var backgroundColor:Color = .yellow
    var elements:[CardElement] = []
    
    mutating func addElement(uiImage: UIImage) {
        let element = ImageElement(uiImage: uiImage)
        elements.append(element)
    }
}
