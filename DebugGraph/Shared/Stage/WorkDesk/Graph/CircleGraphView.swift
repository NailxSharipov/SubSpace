//
//  CircleGraphView.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 05.12.2021.
//

import SwiftUI

struct CircleGraphView: View {

    struct Edge {
        let a: Int
        let b: Int
        let width: CGFloat
        let color: Color
    }
    
    struct Node {
        let index: Int
        let radius: CGFloat
        let color: Color
    }
    
    struct Data {
        let radius: CGFloat
        let center: CGPoint
        let nodes: [Node]
        let edges: [Edge]
    }

    private let dots: [DotView.Data]
    private let arcs: [ArcView.Data]
    private let edges: [EdgeView.Data]
    
    init(data: Data) {
        self.dots = Self.convert(count: data.nodes.count, radius: data.radius, center: data.center, nodes: data.nodes)
        let result = Self.convert(count: data.nodes.count, radius: data.radius, center: data.center, edges: data.edges)
        self.arcs = result.arcs
        self.edges = result.edges
    }
    
    init(nodes: [Node], edges: [Edge], radius: CGFloat, center: CGPoint) {
        self.dots = Self.convert(count: nodes.count, radius: radius, center: center, nodes: nodes)
        let result = Self.convert(count: nodes.count, radius: radius, center: center, edges: edges)
        self.arcs = result.arcs
        self.edges = result.edges
    }
    
    init(nodes: [Node], edges: [Edge], distance: CGFloat, center: CGPoint) {
        let radius = distance * CGFloat(nodes.count) / (2 * .pi)
        self.dots = Self.convert(count: nodes.count, radius: radius, center: center, nodes: nodes)
        let result = Self.convert(count: nodes.count, radius: radius, center: center, edges: edges)
        self.arcs = result.arcs
        self.edges = result.edges
    }
    
    var body: some View {
        ZStack {
            ForEach(arcs) { arc in
                ArcView(data: arc)
            }
            ForEach(edges) { edge in
                EdgeView(data: edge)
            }
            ForEach(dots) { dot in
                DotView(
                    point: dot.point,
                    name: dot.name,
                    color: dot.color
                )
            }
        }
    }
    
    private static func convert(count: Int, radius: CGFloat, center: CGPoint, edges: [Edge]) -> (arcs: [ArcView.Data], edges: [EdgeView.Data]) {
        let dA: CGFloat = 2 * .pi / CGFloat(count)
        
        var arcs = [ArcView.Data]()
        arcs.reserveCapacity(edges.count)
        
        var edgeList = [EdgeView.Data]()
        
        for edge in edges {
            let id = edge.getId(count: count)
            let a = CGPoint(index: edge.a, dA: dA, radius: radius) + center
            let b = CGPoint(index: edge.b, dA: dA, radius: radius) + center

            if edge.isNeighbour(count: count) {
                arcs.append(
                    .init(
                        id: id,
                        start: a,
                        end: b,
                        center: center,
                        color: edge.color,
                        lineWidth: edge.width
                    )
                )
            } else {
                let m = 0.5 * (a + b)
                let d = m - center
                if d.magnitude > 1 {
                    let mc = (m - center).normalize
                    let cc = m + 2 * radius * mc
                    arcs.append(
                        .init(
                            id: id,
                            start: a,
                            end: b,
                            center: cc,
                            color: edge.color,
                            lineWidth: edge.width
                        )
                    )
                } else {
                    edgeList.append(
                        .init(
                            id: id,
                            start: a,
                            end: b,
                            color: edge.color,
                            lineWidth: edge.width
                        )
                    )
                }
            }
        }
        
        return (arcs, edgeList)
    }
    
    private static func convert(count: Int, radius: CGFloat, center: CGPoint, nodes: [Node]) -> [DotView.Data] {
        let dA: CGFloat = 2 * .pi / CGFloat(count)
        
        var result = [DotView.Data]()
        result.reserveCapacity(nodes.count)
        
        for node in nodes {
            let p = CGPoint(index: node.index, dA: dA, radius: radius) + center
            result.append(.init(id: node.index, point: p, name: String(node.index), color: node.color))
        }
        
        return result
    }
                
}

private extension CircleGraphView.Edge {
    
    func getId(count: Int) -> Int {
        if a > b {
            return b * count + a
        } else {
            return a * count + b
        }
    }

    func isNeighbour(count: Int) -> Bool {
        let d = abs(a - b)
        return d == 1 || d == count - 1
    }
    
}

private extension CGPoint {
    
    init(index: Int, dA: CGFloat, radius: CGFloat) {
        let angle = dA * CGFloat(index)
        self.init(radius: radius, angle: angle)
    }
}
