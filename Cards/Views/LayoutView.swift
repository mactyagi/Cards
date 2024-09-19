//
//  LayoutView.swift
//  Cards
//
//  Created by manukant tyagi on 19/09/24.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
        HStack {
            Text("hello world!")
                .background(Color.red)
            Text("Hello World!")
                .padding()
                .background(Color.red)
        }
//        .frame(maxWidth: .infinity)
        .background(Color.gray)
    }
}

#Preview {
    LayoutView()
        .previewLayout(.fixed(width: 500, height: 300))
}
