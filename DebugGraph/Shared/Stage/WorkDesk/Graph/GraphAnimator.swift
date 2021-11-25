//
//  GraphAnimator.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 21.11.2021.
//

import SwiftUI

final class GraphAnimator {

    struct State {
        let dots: [DotView.Data]
        let edges: [EdgeView.Data]
    }

    private let timeInterval: TimeInterval
    private var prevDate: Date = .now

    private var pnts: [CGPoint]
    private var vels: [CGPoint]
    private let graph: Graph
    private let radius: CGFloat
    private let edgeNormalColor: Color = .green
    private let edgeStrongColor: Color = .red
    
    init(graph: Graph, timeInterval: TimeInterval, radius: CGFloat) {
        self.graph = graph
        self.timeInterval = timeInterval
        self.radius = radius
        let n = graph.size
        self.pnts = [CGPoint](repeating: .zero, count: n)
        self.vels = [CGPoint](repeating: .zero, count: n)
        
        let k = 2 * CGFloat.pi / CGFloat(n)
        for i in 0..<n {
            let a = k * CGFloat(i)
            self.pnts[i] = CGPoint(
                x: radius * cos(a),
                y: radius * sin(a)
            )
        }
    }

    func iterate(date: Date) {
        guard !pnts.isEmpty else { return }

        let difference = date.timeIntervalSince(prevDate)
        prevDate = date
        
        let dt = min(difference, timeInterval)

        let n = graph.size
        
        var accs = [CGPoint](repeating: .zero, count: n)

        for i in 0..<n {
            let pi = pnts[i]
            for j in 0..<n where i != j {
                let pj = pnts[j]
                let vr = pi - pj
                let r = vr.length
                let g = 100 / r
                let vn = (1 / r) * vr
                let a0 = g * vn
                let a1: CGPoint
                if graph.isExist(edge: .init(a: i, b: j)) && radius < r {
                    let dr = r - radius
                    a1 = 0.1 * dr * vn
                } else {
                    a1 = .zero
                }
                
                accs[j] = accs[j] - a0 + a1
                accs[i] = accs[i] + a0 - a1
            }
        }
        
        
        
        for i in 0..<n {
            let a = accs[i]
            let v = vels[i] + dt * a
            vels[i] = 0.995 * v
            let p = pnts[i] + dt * v
            pnts[i] = p
        }
    }
    
    func state(size: CGSize) -> State {
        var minX = pnts[0].x
        var minY = minX
        var maxX = minX
        var maxY = minX
        
        for p in pnts {
            if minX > p.x {
                minX = p.x
            }
            
            if minY > p.y {
                minY = p.y
            }
            
            if maxX < p.x {
                maxX = p.x
            }
            
            if maxY < p.y {
                maxY = p.y
            }
        }
        
        let dx = maxX - minX
        let dy = maxY - minY
        
        guard dx > 0 || dy > 0 else { return State(dots: [], edges: []) }
        
        let kx = size.width / dx
        let ky = size.height / dy
        let k = min(kx, ky)
        
        let offsetX = 0.5 * (size.width - k * dx)
        let offsetY = 0.5 * (size.height - k * dy)

        let n = pnts.count
        
        var dots = [DotView.Data]()
        for i in 0..<n {
            let p = pnts[i]
            let sx = ceil(k * (p.x - minX) + offsetX)
            let sy = ceil(k * (p.y - minY) + offsetY)
            dots.append(.init(id: i, point: CGPoint(x: sx, y: sy), name: String(i), color: .red))
        }
        
        var edges = [EdgeView.Data]()
        let r = radius * k
        for edge in graph.edges {
            let id = n * edge.a + edge.b
            let a = dots[edge.a].point
            let b = dots[edge.b].point
            
            let ab = (a - b).length
            let color: Color
            if r < ab {
                let k = ab / r - 1
                if k < 1 {
                    let r0: CGFloat = 0.7
                    let g0: CGFloat = 0.7
                    let b0: CGFloat = 0.7

                    let r1: CGFloat = 1
                    let g1: CGFloat = 0
                    let b1: CGFloat = 0
                    
                    color = Color(
                        red: r0 + k * (r1 - r0),
                        green: g0 + k * (g1 - g0),
                        blue: b0 + k * (b1 - b0),
                        opacity: 1
                    )
                } else {
                    color = Color(red: 1, green: 0, blue: 0, opacity: 1)
                }
            } else {
                color = Color(red: 0.7, green: 0.7, blue: 0.7, opacity: 1)
            }
            
            edges.append(.init(id: id, points: [a, b], color: color))
        }
        
        return State(dots: dots, edges: edges)
    }
    
}
