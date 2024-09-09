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
            default:
                Text(String(describing: item))
            }
        }
    }
}

extension View {
    func cardToolbar(modal: Binding<ToolbarSelection?>) -> some View {
        modifier(CardToolbar(currentModal: modal))
    }
}
