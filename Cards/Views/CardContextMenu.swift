//
//  CardContextMenu.swift
//  Cards
//
//  Created by manukant tyagi on 13/09/24.
//

import SwiftUI

struct CardContextMenu: ViewModifier {
    var card: Card
    @EnvironmentObject var store: CardStore
    func body(content: Content) -> some View {
        content
            .contextMenu {
                Button(role: .destructive) {
                    store.remove(card)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}


extension View {
    func cardContextMenu(card: Card) -> some View {
        modifier(CardContextMenu(card: card))
    }
}
