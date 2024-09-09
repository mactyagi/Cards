//
//  CardStore.swift
//  Cards
//
//  Created by Manu on 07/09/24.
//

import SwiftUI

class CardStore: ObservableObject {
    @Published var cards: [Card] = []
}
