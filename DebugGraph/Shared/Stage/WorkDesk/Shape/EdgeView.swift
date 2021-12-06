//
//  EdgeView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct EdgeView: View {

    struct Data: Identifiable {
        let id: Int
        let points: [CGPoint]
        let color: Color
        let lineWidth: CGFloat
    }
    
    private let color: Color
    private let lineWidth: CGFloat
    private let points: [CGPoint]
    
    init(points: [CGPoint], lineWidth: CGFloat = 3, color: Color = .gray) {
        self.points = points
        self.lineWidth = lineWidth
        self.color = color
    }
    
    init(data: Data) {
        self.points = data.points
        self.lineWidth = data.lineWidth
        self.color = data.color
    }

    var body: some View {
        ZStack {
            Path { path in
                path.addLines(points)
                path.closeSubpath()
            }.strokedPath(.init(lineWidth: lineWidth, lineCap: .round)).foregroundColor(color)
        }
    }
}
