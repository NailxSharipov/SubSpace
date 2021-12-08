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
        let start: CGPoint
        let end: CGPoint
        let color: Color
        let lineWidth: CGFloat
    }

    private let start: CGPoint
    private let end: CGPoint
    private let color: Color
    private let lineWidth: CGFloat
    
    
    init(start: CGPoint, end: CGPoint, lineWidth: CGFloat, color: Color) {
        self.start = start
        self.end = end
        self.lineWidth = lineWidth
        self.color = color
    }
    
    init(data: Data) {
        start = data.start
        end = data.end
        lineWidth = data.lineWidth
        color = data.color
    }

    var body: some View {
        Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }.strokedPath(.init(lineWidth: lineWidth, lineCap: .round)).foregroundColor(color)
    }
}
