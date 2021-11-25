//
//  SceneView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct SceneView: View {

    @ObservedObject var logic: SceneLogic
    private let state: DragAreaState
    
    init(state: DragAreaState, logic: SceneLogic) {
        self.state = state
        self.logic = logic
    }

    var body: some View {
        let viewModel = self.logic.viewModel

        return ZStack {
            ForEach(viewModel.lines) { line in
                EdgeView(
                    state: state,
                    points: line.points,
                    lineWidth: 1,
                    color: Color(white: 0.5, opacity: 0.5)
                )
            }
            ForEach(viewModel.dots) { dot in
                DotView(
                    state: state,
                    point: dot.point,
                    name: dot.name,
                    color: Color.gray
                )
            }
        }.allowsHitTesting(false)
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView(state: DragAreaState(), logic: SceneLogic())
    }
}


private extension Color {
    static let edge = Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1)
    static let horde = Color(red: 1, green: 0, blue: 0, opacity: 0.1)
    static let step = Color(red: 0, green: 0, blue: 1.0, opacity: 0.4)
}
