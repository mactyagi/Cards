//
//  SingleCardView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct SingleCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentModal: ToolbarSelection?
    var body: some View {
        NavigationStack {
            Color.yellow
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
}

#Preview {
    SingleCardView()
}
