//
//  EdgeView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct EdgeView: View {
    private let color: Color
    private let lineWidth: CGFloat
    private let points: [CGPoint]

    struct Data: Identifiable {
        let id: Int
        let points: [CGPoint]
        let color: Color
    }
    
    init(points: [CGPoint], lineWidth: CGFloat = 3, color: Color = .gray) {
        self.points = points
        self.lineWidth = lineWidth
        self.color = color
    }

    var body: some View {
        
        return ZStack {
            Path { path in
                path.addLines(points)
                path.closeSubpath()
            }.strokedPath(.init(lineWidth: lineWidth, lineCap: .round)).foregroundColor(color)
        }
    }
}
