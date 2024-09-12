//
//  CardsApp.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

@main
struct CardsApp: App {
    @StateObject var store = CardStore( defaultData: true)
    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(store)
        }
    }
}
