//
//  SceneLogic.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI
import IntGraph

final class SceneLogic: ObservableObject {

    private let key = String(describing: SceneLogic.self)
    private let data = SceneData.data
    
//    var graph = Graph(edges: [
//        Edge(a: 0, b: 1),
//        Edge(a: 0, b: 2),
//        Edge(a: 1, b: 3),
//        Edge(a: 2, b: 3),
//
//        Edge(a: 3, b: 16),
//
//        Edge(a: 4, b: 5),
//        Edge(a: 4, b: 7),
//        Edge(a: 5, b: 6),
//        Edge(a: 6, b: 7),
//
//        Edge(a: 4, b: 17),
//
//        Edge(a: 8, b: 9),
//        Edge(a: 8, b: 11),
//        Edge(a: 9, b: 10),
//        Edge(a: 10, b: 11),
//
//        Edge(a: 8, b: 18),
//
//        Edge(a: 12, b: 13),
//        Edge(a: 12, b: 15),
//        Edge(a: 13, b: 14),
//        Edge(a: 14, b: 15),
//
//        Edge(a: 12, b: 19),
//
//        Edge(a: 16, b: 17),
//        Edge(a: 16, b: 19),
//        Edge(a: 17, b: 18),
//        Edge(a: 18, b: 19),
//    ])

//        var graph = Graph(edges: [
//            Edge(a: 0, b: 1),
//            Edge(a: 0, b: 2),
//            Edge(a: 0, b: 4),
//            Edge(a: 0, b: 5),
//            Edge(a: 0, b: 6),
//            Edge(a: 1, b: 3),
//            Edge(a: 1, b: 4),
//            Edge(a: 1, b: 6),
//            Edge(a: 2, b: 3),
//            Edge(a: 2, b: 4),
//            Edge(a: 2, b: 7),
//            Edge(a: 3, b: 4),
//            Edge(a: 5, b: 7),
//        ])
    
//    var graph = Graph(edges: [
//        Edge(a: 1, b: 0),
//        Edge(a: 1, b: 3),
//        Edge(a: 1, b: 4),
//        Edge(a: 1, b: 5),
//        Edge(a: 2, b: 3),
//        Edge(a: 2, b: 4),
//    ])
    var graph = Graph(edges: [
    Edge(a: 0, b: 1),
    Edge(a: 0, b: 6),
    Edge(a: 1, b: 2),
    Edge(a: 1, b: 3),
    Edge(a: 2, b: 3),
    Edge(a: 2, b: 4),
    Edge(a: 3, b: 4),
    Edge(a: 4, b: 5),
    Edge(a: 6, b: 7),
    Edge(a: 6, b: 8),
    Edge(a: 7, b: 8),
    Edge(a: 7, b: 9),
    Edge(a: 8, b: 9),
    Edge(a: 9, b: 5),
    ])
    func getGraphState(size: CGSize) -> CircleGraphView.Data {
        var nodes = [CircleGraphView.Node]()

        let color = Color(red: 0.5, green: 0.5, blue: 1, opacity: 1)
        
        for i in 0..<graph.size {
            nodes.append(.init(index: i, radius: 5, color: color))
        }
        
        var edges = [CircleGraphView.Edge]()
        let edgeList = graph.edges
        for edge in edgeList {
            edges.append(.init(a: edge.a, b: edge.b, width: 4, color: color))
        }
        
        let rx = ceil(0.5 * size.width)
        let ry = ceil(0.5 * size.height)
        
        let center = CGPoint(x: rx, y: ry)
        let radius = min(rx, ry) - 30
        
        return .init(radius: radius, center: center, nodes: nodes, edges: edges)
    }
    
}
