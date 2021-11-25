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
            ZStack {
                EdgeView(
                    state: state,
                    points: viewModel.line.points,
                    lineWidth: 5,
                    color: .init(red: 0.3, green: 0.3, blue: 1, opacity: 0.8)
                )
                ForEach(viewModel.lines) { line in
                    EdgeView(
                        state: state,
                        points: line.points,
                        lineWidth: 1.1,
                        color: .init(red: 0.2, green: 0.8, blue: 0.6, opacity: 0.4)
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
            VStack {
                HStack {
                    Picker("A", selection: $logic.a) {
                        ForEach(0..<logic.points.count) { index in
                            Text(String(index)).font(.body).foregroundColor(.black)
                        }
                    }.foregroundColor(.black).font(.title2)
                    Picker("B", selection: $logic.b) {
                        ForEach(0..<logic.points.count) { index in
                            Text(String(index)).font(.body).foregroundColor(.black)
                        }
                    }.foregroundColor(.black).font(.title2)
                }.padding([.top, .leading, .trailing], 16)
                HStack {
                    Toggle(
                        "FullConnectivity", isOn: $logic.isFullConnectivity
                    ).foregroundColor(.black).font(.title2)
                    Spacer()
                }.padding([.leading, .trailing], 16)
                Spacer()
            }
        }
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
