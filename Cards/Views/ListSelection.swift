//
//  ListSelection.swift
//  Cards
//
//  Created by manukant tyagi on 23/09/24.
//

import SwiftUI

enum ListState: CaseIterable {
    case list, crousal
}

struct ListSelection: View {
    @Binding var selection: ListState
    var body: some View {
        Picker(selection: $selection) {
            Image(systemName: "square.grid.2x2.fill")
                .tag(ListState.list)
            Image(systemName: "rectangle.stack.fill")
                .tag(ListState.crousal)
        } label: {
            
        }
        .pickerStyle(.segmented)
        .frame(width: 200)

    }
}

#Preview {
    ListSelection(selection: .constant(.list))
}
