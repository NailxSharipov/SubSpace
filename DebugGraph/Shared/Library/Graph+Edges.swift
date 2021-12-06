//
//  Graph+Edges.swift
//  DebugGraph
//
//  Created by Nail Sharipov on 21.11.2021.
//

import IntGraph

extension Graph {
    
    var edges: [Edge] {
        var result = [Edge]()
        nodes.forEachIndex { a in
            let node = nodes[a]
            node.forEach { b in
                if a < b {
                    result.append(Edge(a: a, b: b))
                }
            }
        }
        return result
    }
}
