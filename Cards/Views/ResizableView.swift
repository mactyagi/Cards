//
//  ResizableView.swift
//  Cards
//
//  Created by Manu on 06/09/24.
//

import SwiftUI

struct ResizableView: ViewModifier {
    @State private var transform = Transform()
    @State private var previousRotation: Angle = .zero
    @State private var previousOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    
    var scaleGesture: some Gesture {
            MagnificationGesture()
            .onChanged { scale in
                self.scale = scale
            }
            .onEnded { scale in
                transform.size.width *= scale
                transform.size.height *= scale
                self.scale = 1.0
            }
    }
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { rotation in
                transform.rotation += rotation - previousRotation
                previousRotation = rotation
            }
            .onEnded { _ in
                previousRotation = .zero
            }
    }
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                transform.offset = value.translation + previousOffset
            }
            .onEnded { _ in
                previousOffset = transform.offset
            }
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: transform.size.width, height: transform.size.height)
            .rotationEffect(transform.rotation)
            .scaleEffect(scale)
            .offset(transform.offset)
            .gesture(dragGesture)
            .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
    }
}

extension View {
    func resizableView() -> some View {
        modifier(ResizableView())
    }
}

#Preview {
    
    RoundedRectangle(cornerRadius: 30)
        .foregroundColor(.blue)
        .resizableView()
}
