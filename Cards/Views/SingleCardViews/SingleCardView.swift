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
            CardDetailView(card: $card)
                .cardToolbar(modal: $currentModal, card: $card)
                .onDisappear {
                    card.save()
                }
        }
    }
}

#Preview {
    SingleCardView(card: .constant(initialCards[0]))
        .environmentObject(CardStore())
}
