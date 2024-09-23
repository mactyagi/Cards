//
//  TextModal.swift
//  Cards
//
//  Created by manukant tyagi on 15/09/24.
//

import SwiftUI

struct TextModal: View {
    @Binding var textElement: TextElement
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            TextField("Enter Text", text: $textElement.text) {
                dismiss()
            }
            .font(.custom(textElement.textFont, size: 30))
            .fontWeight(.heavy)
            .foregroundColor(textElement.textColor)
            .padding(40)
            TextView(font: $textElement.textFont, color: $textElement.textColor)
        }
    }
}

#Preview {
    TextModal(textElement: .constant(TextElement()))
}
