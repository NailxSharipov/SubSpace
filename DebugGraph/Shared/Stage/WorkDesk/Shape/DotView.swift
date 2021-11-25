//
//  DotView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct DotView: View {

    private let color: Color
    private let point: CGPoint
    private let name: String
    private let radius: CGFloat
    
    struct Data: Identifiable {
        let id: Int
        let point: CGPoint
        let name: String
        let color: Color
    }

    init(point: CGPoint, name: String, radius: CGFloat = 5, color: Color = .gray) {
        self.color = color
        self.radius = radius
        self.point = point
        self.name = name
    }

    var body: some View {
        var textPoint: CGPoint = point
        if point.y > 0 {
            textPoint.y -= 12
        } else {
            textPoint.y += 12
        }
        
        return ZStack {
            Circle()
                .fill(self.color)
                .frame(width: 2 * radius, height: 2 * radius)
                .position(x: point.x, y: point.y)
            Text(name).font(.title2).position(textPoint).foregroundColor(.black)
        }
    }
}
