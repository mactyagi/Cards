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
    var imageFileName: String?
    
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


extension TextElement: Codable {
    enum CodingKeys: CodingKey {
        case id,transform, text, textColor, textFont
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        transform = try container.decode(Transform.self, forKey: .transform)
        text = try container.decode(String.self, forKey: .text)
        let colorComponents = try container.decode([CGFloat].self, forKey: .textColor)
        textColor = Color.color(components: colorComponents)
        textFont = try container.decode(String.self, forKey: .textFont)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transform, forKey: .transform)
        try container.encode(text, forKey: .text)
        try container.encode(textColor.colorComponents(), forKey: .textColor)
        try container.encode(textFont, forKey: .textFont)
    }
}


extension ImageElement : Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        transform = try container.decode(Transform.self, forKey: .transform)
        
        frameIndex = try container.decodeIfPresent(Int.self, forKey: .frameIndex)
        imageFileName = try container.decodeIfPresent(String.self, forKey: .imageFileName)
        if let imageFileName {
            uiImage = UIImage.load(uuidString: imageFileName)
        }else {
            uiImage = UIImage.errorImage
        }
    }
    
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transform, forKey: .transform)
        try container.encode(frameIndex, forKey: .frameIndex)
        try container.encode(imageFileName, forKey: .imageFileName)
        
    }
    
    
    enum CodingKeys: CodingKey {
        case transform, imageFileName, frameIndex
    }
}


