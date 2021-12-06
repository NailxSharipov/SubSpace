//
//  SceneView.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI

struct SceneView: View {

    private let logic: SceneLogic
    
    init(logic: SceneLogic) {
        self.logic = logic
    }

    var body: some View {
        GeometryReader { geometry in
            CircleGraphView(data: logic.getGraphState(size: geometry.size))
        }.background(Color.yellow).padding(32)
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView(logic: SceneLogic())
    }
}
