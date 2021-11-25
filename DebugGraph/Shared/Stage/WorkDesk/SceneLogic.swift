//
//  SceneLogic.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI
import SubSpace

final class SceneLogic: ObservableObject {

    private let key = String(describing: SceneLogic.self)
    private let data = SceneData.data

    let animator: GraphAnimator
//    var graph = Graph(edges: [
//        .init(a: 0, b: 1),
//        .init(a: 0, b: 4),
//        .init(a: 0, b: 5),
//        .init(a: 1, b: 3),
//        .init(a: 1, b: 4),
//        .init(a: 1, b: 6),
//        .init(a: 2, b: 0),
//        .init(a: 2, b: 3),
//        .init(a: 2, b: 4),
//        .init(a: 2, b: 7),
//        .init(a: 3, b: 4),
//        .init(a: 5, b: 7),
//    ])
    
    var graph = Graph(edges: [
        .init(a: 0, b: 1),
        .init(a: 0, b: 2),
        .init(a: 1, b: 3),
        .init(a: 2, b: 3),
        
        .init(a: 3, b: 16),
        
        .init(a: 4, b: 5),
        .init(a: 4, b: 7),
        .init(a: 5, b: 6),
        .init(a: 6, b: 7),
        
        .init(a: 4, b: 17),
        
        .init(a: 8, b: 9),
        .init(a: 8, b: 11),
        .init(a: 9, b: 10),
        .init(a: 10, b: 11),
        
        .init(a: 8, b: 18),
        
        .init(a: 12, b: 13),
        .init(a: 12, b: 15),
        .init(a: 13, b: 14),
        .init(a: 14, b: 15),
        
        .init(a: 12, b: 19),
        
        .init(a: 16, b: 17),
        .init(a: 16, b: 19),
        .init(a: 17, b: 18),
        .init(a: 18, b: 19),
    ])
    
    init() {
        animator = GraphAnimator(graph: graph, timeInterval: 0.02, radius: 50)
    }

}
