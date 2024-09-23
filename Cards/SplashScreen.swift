//
//  SplashScreen.swift
//  Cards
//
//  Created by manukant tyagi on 21/09/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            card(letter: "S", color: .appColor1)
                .splashAnimation(finalYPosition: 240, delay: 0)
            card(letter: "D", color: .appColor2)
                .splashAnimation(finalYPosition: 120, delay: 0.2)
            card(letter: "R", color: .appColor3)
                .splashAnimation(finalYPosition: 0, delay: 0.4)
            card(letter: "A", color: .appColor6)
                .splashAnimation(finalYPosition: -120, delay: 0.6)
            card(letter: "C", color: .appColor7)
                .splashAnimation(finalYPosition: -240, delay: 0.8)
            
        }
       
    }
    
    func card(letter: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .shadow(radius: 3)
                .frame(width: 120, height: 160)
                .foregroundColor(.white)
            Text(letter)
                .fontWeight(.bold)
                .scalableText()
                .foregroundColor(color)
                .frame(width: 80)

        }
    }
}

#Preview {
    SplashScreen()
}


private struct SplashAnimation: ViewModifier {
    @State private var animating = true
    let finalYPosition: CGFloat
    let delay: Double
    let animation = Animation.interpolatingSpring(mass: 0.4, stiffness: 80, damping: 5, initialVelocity: 0)
    
    func body(content: Content) -> some View {
        content
            .offset(y: animating ? -700 : finalYPosition)
            .rotationEffect(animating ? .zero : Angle(degrees: Double.random(in: -10...10)))
            .animation(animation.delay(delay),value: animating)
            .onAppear{
//                withAnimation(animation.delay(delay)) {
//                    animating = false
//                }
                animating = false
            }
    }
}

private extension View {
    func splashAnimation(finalYPosition: CGFloat, delay: Double) -> some View {
        modifier(SplashAnimation(finalYPosition: finalYPosition, delay: delay))
    }
}
