//
//  CardThumbnail.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct CardThumbnail: View {
    let card: Card
    var body: some View {
        Group {
            if let uiImage = UIImage.load(uuidString: card.id.uuidString) {
                Image(uiImage: uiImage)
                    .resizable()
            }else {
                card.backgroundColor
            }
        }
            .cornerRadius(10)
            .shadow(
                color: .shadow,
                radius: 3,
                x: 0.0,
                y: 0.0)
        
    }
}

#Preview {
    CardThumbnail(card: initialCards[0])
        .frame(
          width: Settings.thumbnailSize.width,
          height: Settings.thumbnailSize.height)
}
