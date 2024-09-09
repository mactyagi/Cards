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
            content
                .cardToolbar(modal: $currentModal)
        }
    }
    
    var content : some View {
        ZStack {
            Group {
                Capsule()
                    .foregroundColor(.yellow)
                Text("Resize Me!")
                    .fontWeight(.bold)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
            .resizableView()
            
            Circle()
                .resizableView()
                .offset(CGSize(width: 50.0, height: 200.0))
        }
    }
}

#Preview {
    SingleCardView()
}
