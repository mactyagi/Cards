//
//  CardToolbar.swift
//  Cards
//
//  Created by Manu on 07/09/24.
//

import SwiftUI

struct CardToolbar: ViewModifier {
    @Binding var currentModal: ToolbarSelection?
    @Environment(\.dismiss) var dismiss
    @Binding var card: Card
    @State private var stickerImage: UIImage?
    
    func body(content: Content) -> some View {
        content
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BottomToolbar(modal: $currentModal)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
        .sheet(item: $currentModal) { item in
            switch item {
            case .stickerModal:
                StickerModal(stickerImage: $stickerImage)
                    .onDisappear {
                        if let stickerImage {
                            card.addElement(uiImage: stickerImage)
                        }
                        stickerImage = nil
                    }
            default:
                Text(String(describing: item))
            }
        }
    }
}

extension View {
    func cardToolbar(modal: Binding<ToolbarSelection?>, card: Binding<Card>) -> some View {
        modifier(CardToolbar(currentModal: modal, card: card))
    }
}
