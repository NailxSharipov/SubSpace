//
//  GraphView.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 21.11.2021.
//

import SwiftUI

struct GraphView: View {

    private let state: GraphAnimator.State
    
    init(state: GraphAnimator.State) {
        self.state = state
    }
    
    var body: some View {
        ZStack {
            ForEach(state.edges) { edge in
                EdgeView(
                    points: edge.points,
                    lineWidth: 3,
                    color: edge.color
                )
            }
            ForEach(state.dots) { dot in
                DotView(
                    point: dot.point,
                    name: dot.name,
                    color: dot.color
                )
            }
        }
    }
}
