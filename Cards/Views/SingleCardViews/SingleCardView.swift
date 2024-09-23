//
//  SingleCardView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct SingleCardView: View {
    @Binding var card : Card
    @Environment(\.dismiss) var dismiss
    @State private var currentModal: ToolbarSelection?
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                CardDetailView(card: $card, proxy: proxy)
                    .frame(
                        width: Settings.calculateSize(proxy.size).width,
                        height: Settings.calculateSize(proxy.size).height)
                    .clipped()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                    .cardToolbar(modal: $currentModal, card: $card)
                    .onDisappear {
                        let image = UIImage.screenshot(card: card, size: Settings.cardSize)
                        image.save(to: card.id.uuidString)
                        card.uiImage = image
                        card.save()
                }
            }
        }
    }
}

#Preview {
    SingleCardView(card: .constant(initialCards[0]))
        .environmentObject(CardStore())
}
