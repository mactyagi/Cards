//
//  CardsListView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var store: CardStore
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedCard: Card?
    var body: some View {
        VStack {
            list
                .fullScreenCover(item: $selectedCard, content: { card in
                    if let index = store.index(for: card) {
                        SingleCardView(card: $store.cards[index])
                            .onChange(of: scenePhase) { newScenePhase in
                                if newScenePhase == .inactive {
                                    store.cards[index].save()
                                }
                            }
                        
                    }else {
                        fatalError("Unable to locate selected card")
                    }
                    
            })
            Button("Add") {
                selectedCard = store.addCard()
            }
        }
    }
    
    var list: some View {
      ScrollView(showsIndicators: false) {
        VStack {
            ForEach(store.cards) { card in
                CardThumbnail(card: card)
                    .cardContextMenu(card: card)
              .onTapGesture {
                selectedCard = card
              }
          }
        }
      }
    }
}

#Preview {
    CardsListView()
        .environmentObject(CardStore(defaultData: true))
}


