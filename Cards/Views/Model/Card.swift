//
//  Card.swift
//  Cards
//
//  Created by Manu on 07/09/24.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var backgroundColor:Color = .yellow
    var elements:[CardElement] = []
    
    mutating func addElement(uiImage: UIImage, at offset: CGSize = .zero) {
        let imageFileName = uiImage.save()
        let transform = Transform(offset: offset)
        print("This is off set")
        let element = ImageElement(
            transform: transform,
            imageFileName: imageFileName,
            uiImage: uiImage)
        elements.append(element)
        save()
    }
    
    mutating func addElement(textElement: TextElement, at offset: CGSize = .zero) {
        let transform = Transform(offset: offset)
        var newTextElement = textElement
        newTextElement.transform = transform
        elements.append(newTextElement)
        save()
    }
    
    mutating func addElements(from transfer: [CustomTransfer], at offset: CGSize) {
        for element in transfer {
            if let text = element.text {
                addElement(textElement: TextElement(text: text), at: offset)
            }else if let image = element.image {
                addElement(uiImage: image, at: offset)
            }
        }
    }
    
    mutating func remove(_ element: CardElement) {
        if let element = element as? ImageElement {
            UIImage.remove(name: element.imageFileName)
        }
        if let index = element.index(in: elements) {
            elements.remove(at: index)
        }
        save()
    }
    
    mutating func update(_ element: CardElement?, frameIndex: Int) {
        if let element = element as? ImageElement,
           let index = element.index(in: elements) {
            var newElement = element
            newElement.frameIndex = frameIndex
            elements[index] = newElement
        }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let fileName = "\(id).rwcard"
            let url = URL.documentsDirectory.appendingPathComponent(fileName)
            try data.write(to: url)
        }catch {
            print(error.localizedDescription)
        }
    }
}


extension Card: Codable {
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: id) ?? UUID()
        let colorComponent = try container.decode([CGFloat].self, forKey: .backgroundColor)
        self.backgroundColor = Color.color(components: colorComponent)
        elements += try container.decode([ImageElement].self, forKey: .imageElements)
        elements += try container.decode([TextElement].self, forKey: .textElements)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        let imageElements: [ImageElement] = elements.compactMap { $0 as? ImageElement }
        try container.encode(imageElements, forKey: .imageElements)
        let colorComponents = backgroundColor.colorComponents()
        try container.encode(colorComponents, forKey: .backgroundColor)
        let textElements = elements.compactMap { $0 as? TextElement }
        try container.encode(textElements, forKey: .textElements)
        
    }
    
    enum CodingKeys: CodingKey {
        case id, backgroundColor, imageElements, textElements
    }
}
