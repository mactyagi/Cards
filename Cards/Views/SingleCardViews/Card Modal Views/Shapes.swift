//
//  Shapes.swift
//  Cards
//
//  Created by manukant tyagi on 13/09/24.
//

import SwiftUI


enum Shapes {
    static let shapes: [AnyShape] = [
        AnyShape(Circle()),
        AnyShape(Rectangle()),
        AnyShape(Cone()),
        AnyShape(RoundedRectangle(cornerRadius: 25)),
        AnyShape(Lens())
        ]
}

#Preview {
    VStack {

        Heart()
            .stroke(Color.primary, style: StrokeStyle(lineWidth: 10, lineJoin: .round))
            .padding()
            .aspectRatio(1, contentMode: .fit)
            .background(Color.yellow)
        
    }
    .padding()
}

struct Arrow: Shape {
//    func path(in rect: CGRect) -> Path {
//        let pat = Path()
//        
//    }
    
    
}

struct Heart : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        path.move(to: CGPoint(x: 0, y: rect.midY / 2))
//        path.addLine(to: CGPoint(x: 10, y: rect.midY / 2))
        path.addArc(
            center: CGPoint(x: rect.midX / 2, y: rect.midY / 2),
            radius: rect.midX / 2,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 0),
            clockwise: false)
        
        path.addArc(
            center: CGPoint(x: rect.midX * 3 / 2, y: rect.midY / 2),
            radius: rect.midX / 2,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 0),
            clockwise: false)
        
        
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.height),
            control: CGPoint(x: rect.width, y: rect.midY))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.midY / 2),
            control: CGPoint(x: 0, y: rect.midY))
        
        path.closeSubpath()
        return path
    }
    
    
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        path.addLines([
            CGPoint(x: width * 0.13, y: height * 0.2),
            CGPoint(x: width * 0.87, y: height * 0.47),
            CGPoint(x: width * 0.4, y: height * 0.93)
        ])
        path.closeSubpath()
        return path
    }
}

struct Cone: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.midX, rect.midY)
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: true)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.midX + radius, y: rect.midY))
        return path
    }
}


struct Lens: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.midY),
            control: CGPoint(x: rect.midX, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.midY),
            control: CGPoint(x: rect.midX, y: rect.height))
        path.closeSubpath()
        return path
    }
    
    
}

