//
//  BottomToolbar.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct ToolbarButton: View {
    let modal: ToolbarSelection
    @Environment(\.verticalSizeClass) var verticalSizeClass
    private let modalButton: [ToolbarSelection: (text: String, imageName: String)] = [
        .photoModal : ("Photos","photo"),
        .frameModal : ("Frames", "square.on.circle"),
        .stickerModal : ("Stickers", "heart.circle"),
        .textModal : ("Text", "textformat")
    ]
    
    var body: some View {
        if let text = modalButton[modal]?.text, let imageName = modalButton[modal]?.imageName {
            VStack{
                Image(systemName: imageName)
                    .font(.largeTitle)
                if verticalSizeClass == .regular{
                    Text(text)
                }
                
            }
            .padding(.top)
        }

    }
}

struct BottomToolbar: View {
    @Binding var modal: ToolbarSelection?
    @EnvironmentObject var store: CardStore
    @Binding var card: Card
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(ToolbarSelection.allCases) { selection in
                switch selection {
                case .photoModal:
                    Button {} label: {
                        PhotoModal(card: $card)
                    }
                case .frameModal:
                    defaultButton(selection)
                        .disabled(
                            store.selectedElement == nil ||
                            !(store.selectedElement is ImageElement)
                        )
                default:
                    defaultButton(selection)
                }
            }
        }
    }
    
    func defaultButton(_ selection: ToolbarSelection) -> some View {
        Button {
            modal = selection
        } label: {
            ToolbarButton(modal: selection)
        }
    }
}

#Preview {
    BottomToolbar(modal: .constant(.textModal),
                  card: .constant(Card()))
    .environmentObject(CardStore())
}
