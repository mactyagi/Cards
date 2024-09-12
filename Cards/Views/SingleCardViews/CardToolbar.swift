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
            ToolbarItem(placement: .navigationBarTrailing) {
                menu
            }
            
            ToolbarItem(placement: .bottomBar) {
                BottomToolbar(modal: $currentModal, card: $card)
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
    
    var menu: some View {
        Menu {
            Button(action: {
                if UIPasteboard.general.hasImages {
                    if let images =  UIPasteboard.general.images {
                        for image in images {
                            card.addElement(uiImage: image)
                        }
                    }
                }else if UIPasteboard.general.hasStrings {
                    if let strings = UIPasteboard.general.strings {
                        for text in strings {
                            card.addElement(text: TextElement(text: text))
                        }
                    }
                }
            }, label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            })
            .disabled(!UIPasteboard.general.hasImages && !UIPasteboard.general.hasStrings)
            
        } label: {
            Label("Add", systemImage: "ellipsis.circle")
        }
    }
}

extension View {
    func cardToolbar(modal: Binding<ToolbarSelection?>, card: Binding<Card>) -> some View {
        modifier(CardToolbar(currentModal: modal, card: card))
    }
}
