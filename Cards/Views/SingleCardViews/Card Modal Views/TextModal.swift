//
//  TextModal.swift
//  Cards
//
//  Created by manukant tyagi on 15/09/24.
//

import SwiftUI

struct TextModal: View {
    @Binding var textElement: TextElement
    @Environment (\.dismiss) var dismiss
    var body: some View {
        TextField("Enter Text", text: $textElement.text) {
            dismiss()
        }
        .padding()
    }
}

#Preview {
    TextModal(textElement: .constant(TextElement()))
}
