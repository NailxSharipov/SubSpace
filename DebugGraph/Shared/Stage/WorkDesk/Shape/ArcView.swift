//
//  ArcView.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 05.12.2021.
//

import SwiftUI

struct ArcView: View {

    struct Data: Identifiable {
        let id: Int
        let start: CGPoint
        let end: CGPoint
        let center: CGPoint
        let color: Color
        let lineWidth: CGFloat
    }
    
    private let center: CGPoint
    private let startAngle: Angle
    private let endAngle: Angle
    private let clockwise: Bool
    private let radius: CGFloat
    private let lineWidth: CGFloat
    private let color: Color
    
    init(start: CGPoint, end: CGPoint, center: CGPoint, lineWidth: CGFloat, color: Color) {
        self.center = center
        
        let p0 = start - center
        let p1 = end - center
        
        let polar = CGPoint.polar(p0: p0, p1: p1)
        startAngle = Angle(radians: polar.start)
        endAngle = Angle(radians: polar.end)
        clockwise = polar.clockwise
        radius = p0.length
        
        self.lineWidth = lineWidth
        self.color = color
    }
    
    init(data: Data) {
        center = data.center
        let p0 = data.start - data.center
        let p1 = data.end - data.center
        
        let polar = CGPoint.polar(p0: p0, p1: p1)
        startAngle = Angle(radians: polar.start)
        endAngle = Angle(radians: polar.end)
        clockwise = polar.clockwise
        radius = p0.length
        
        lineWidth = data.lineWidth
        color = data.color
    }

    var body: some View {
       Path { path in
           path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
       }.strokedPath(.init(lineWidth: lineWidth, lineCap: .round)).foregroundColor(color)
    }
}

private extension CGPoint {

    struct Polar {
        let start: Double
        let end: Double
        let clockwise: Bool
    }
    
    static func polar(p0: CGPoint, p1: CGPoint) -> Polar {
        let a0 = atan2(p0.y, p0.x)
        let a1 = atan2(p1.y, p1.x)
        let cp = p0.crossProduct(p1)
        let clockwise = cp <= 0
        return Polar(start: a0, end: a1, clockwise: clockwise)
    }

    private func crossProduct(_ point: CGPoint) -> CGFloat {
        self.x * point.y - self.y * point.x
    }
    
}
