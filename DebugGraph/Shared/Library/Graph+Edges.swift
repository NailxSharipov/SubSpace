//
//  Graph+Edges.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 21.11.2021.
//

extension Graph {
    
    var edges: [Edge] {
        var result = [Edge]()
        for a in 0..<nodes.count {
            let node = nodes[a]
            for b in node where a < b {
                result.append(Edge(a: a, b: b))
            }
        }
        
        return result
    }
}
