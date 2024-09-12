//
//  CardsListView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var store: CardStore
    @State private var selectedCard: Card?
    var body: some View {
        list
            .fullScreenCover(item: $selectedCard, content: { card in
                if let index = store.index(for: card) {
                    SingleCardView(card: $store.cards[index])
                }else {
                    fatalError("Unable to locate selected card")
                }
                
            })
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


