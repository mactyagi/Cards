//
//  CardThumbnail.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct CardThumbnail: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.random())
            .frame(
                width: Settings.thumbnailSize.width,
                height: Settings.thumbnailSize.height)
    }
}

#Preview {
    CardThumbnail()
}
