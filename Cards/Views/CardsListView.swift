//
//  CardsListView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct CardsListView: View {
    @State private var isPresented = false
    var body: some View {
        list
        .fullScreenCover(isPresented: $isPresented) {
            SingleCardView()
        }
    }
    
    var list: some View {
      ScrollView(showsIndicators: false) {
        VStack {
          ForEach(0..<10) { _ in
            CardThumbnail()
              .onTapGesture {
                isPresented = true
              }
          }
        }
      }
    }
}

#Preview {
    CardsListView()
}


