//
//  LayoutView.swift
//  Cards
//
//  Created by manukant tyagi on 19/09/24.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Text("hello world!")
                    .background(Color.red)
                Text("Hello World!")
                    .padding()
                    .background(Color.red)
            }
            .frame(width: proxy.size.width * 0.8)
            .background(Color.gray)
            .padding(
                .leading, (proxy.size.width - proxy.size.width * 0.8) / 2
            )
        }
        .background(Color.yellow)
    }
}

#Preview {
    LayoutView()
        .previewLayout(.fixed(width: 500, height: 300))
}
