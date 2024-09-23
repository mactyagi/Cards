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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var selectedCard: Card?
    @State private var listState: ListState = .list
    var thumbnailSize: CGSize {
        var scale: CGFloat = 1
        if verticalSizeClass == .regular, horizontalSizeClass == .regular {
            scale = 1.5
        }
        return Settings.thumbnailSize * scale
    }
    
    var columns: [GridItem]{
        [
            GridItem(.adaptive(minimum: thumbnailSize.width))
        ]
    }
    var body: some View {
        VStack {
            ListSelection(selection: $listState)
            Group {
                if store.cards.isEmpty {
                    initialView
                }else {
                    Group {
                        switch listState {
                        case .list:
                            list
                        case .crousal:
                            Carousel(selectedCard: $selectedCard)
                        }
                    }
                }
            }
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
            createButton
        }
        .background(
            Color.background
                .ignoresSafeArea()
        )
    }
    
    var list: some View {
      ScrollView(showsIndicators: false) {
          LazyVGrid(columns: columns, spacing: 30) {
            ForEach(store.cards) { card in
                CardThumbnail(card: card)
                    .cardContextMenu(card: card)
                    .frame(width: thumbnailSize.width,height: thumbnailSize.height)
              .onTapGesture {
                selectedCard = card
              }
          }
        }
      }
      .padding(.top, 20)
    }
    
    var createButton: some View {
        Button {
            selectedCard = store.addCard()
        } label: {
            Label("Create New", systemImage: "plus")
                .frame(maxWidth: .infinity)
        }
        .font(.system(size: 16, weight: .bold))
        .padding([.top, .bottom], 10)
        .background(Color.bar)
        .accentColor(.white)
        
    }
    
    var initialView: some View {
        VStack {
            Spacer()
            let card = Card(backgroundColor: Color(UIColor.systemBackground))
            ZStack {
                CardThumbnail(card: card)
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
            }
            .frame(
                width: thumbnailSize.width * 1.2,
                height: thumbnailSize.height * 1.2)
            .onTapGesture {
                selectedCard = store.addCard()
            }
            Spacer()
        }
    }
}

#Preview {
    CardsListView()
        .environmentObject(CardStore(defaultData: true))
}


