//
//  SceneView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct SceneView: View {

    private static let timeInterval: TimeInterval = 0.02
    private let logic: SceneLogic
    
    init(logic: SceneLogic) {
        self.logic = logic
    }

    var body: some View {
        TimelineView(.periodic(from: .now, by: Self.timeInterval)) { context in
            GeometryReader { geometry in
                self.buildContent(size: geometry.size, date: context.date)
            }
        }
        .background(Color.yellow).padding(32)
    }
    
    private func buildContent(size: CGSize, date: Date) -> some View {
        logic.animator.iterate(date: date)
        let state = logic.animator.state(size: size)
        return GraphView(state: state)
    }
    
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView(logic: SceneLogic())
    }
}
