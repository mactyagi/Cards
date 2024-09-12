//
//  PhotoModal.swift
//  Cards
//
//  Created by manukant tyagi on 12/09/24.
//

import SwiftUI
import PhotosUI

struct PhotoModal: View {
    @Binding var card: Card
    @State private var selectedItems: [PhotosPickerItem] = []
    var body: some View {
        PhotosPicker(selection: $selectedItems, matching: .images) {
            ToolbarButton(modal: .photoModal)
        }
        .onChange(of: selectedItems) { items in
            for item in items {
                print(item)
                item.loadTransferable(type: Data.self) { result in
                    Task {
                        switch result {
                        case .success(let data):
                            if let data, let uiImage = UIImage(data: data) {
                                card.addElement(uiImage: uiImage)
                            }
                        case .failure(let failure):
                            fatalError("Image transfer failed: \(failure)")
                        }
                    }
                }
            }
            selectedItems = []
        }
    }
        
}

#Preview {
    PhotoModal(card: .constant(Card()))
}
