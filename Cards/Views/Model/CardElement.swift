//
//  CardElement.swift
//  Cards
//
//  Created by Manu on 07/09/24.
//

import SwiftUI

protocol CardElement {
    var id: UUID {get}
    var transform: Transform {get set}
}

extension CardElement {
    func index(in array: [CardElement]) -> Int? {
        array.firstIndex { $0.id == id }
    }
}

struct ImageElement: CardElement {
    var id: UUID = UUID()
    var frameIndex: Int?
    var transform = Transform()
    
    var image: Image {
        Image(uiImage: uiImage ?? UIImage.error)
    }
    
    var uiImage: UIImage? = nil
}

struct TextElement: CardElement {
    var id = UUID()
    var transform = Transform()
    var text = ""
    var textColor = Color.black
    var textFont = "Gill Sans"
}
