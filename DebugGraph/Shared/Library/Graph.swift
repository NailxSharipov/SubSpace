//
//  Graph.swift
//  DebugGraph (iOS)
//
//  Created by Nail Sharipov on 19.11.2021.
//

struct Graph {

    struct Edge {
        let a: Int
        let b: Int
    }

    var size: Int {
        nodes.count
    }
    
    func isExist(edge: Edge) -> Bool {
        nodes[edge.a]?.contains(edge.b) ?? false
    }
    
    private (set) var nodes: [Int: Set<Int>]
    
    init(nodes: [Set<Int>]) {
        self.nodes = [Int: Set<Int>]()
        self.nodes.reserveCapacity(nodes.count)
        for i in 0..<nodes.count {
            self.nodes[i] = nodes[i]
        }
    }
    
    init(edges: [Edge]) {
        var m = -1
        for edge in edges where edge.a > m || edge.b > m {
            m = max(edge.a, edge.b)
        }
        nodes = [Int: Set<Int>]()
        nodes.reserveCapacity(m)
        for edge in edges {
            self.add(edge: edge)
        }
    }
    
    mutating func add(edge: Edge) {
        nodes[edge.a]?.insert(edge.b)
        nodes[edge.b]?.insert(edge.a)
    }
    
    mutating func removeAllNode(index: Int) {
        nodes[index] = nil
        for i in nodes.keys {
            nodes[i]?.remove(i)
        }
    }
    
}

extension Graph {
    
    var minVertexModule: Int {
        var min = self.size
        for node in nodes.values {
            let count = node.count
            if count < min {
                min = count
            }
        }
        return min
    }
    
    var isConective: Bool {
        guard let first = nodes.keys.first, var buffer = nodes[first] else { return true }
        let n = nodes.count
        var visited = Set<Int>()
        visited.reserveCapacity(n)
        visited.insert(first)
        visited.formUnion(buffer)
        
        var next = Set<Int>()
        next.reserveCapacity(n)
        
        while visited.count < n && !buffer.isEmpty {
            for key in buffer {
                if let node = nodes[key] {
                    next.formUnion(node)
                }
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }

        return visited.count == n
    }
    
    mutating func eliminateTwoEdgeVertices() {
        
        
        
        
        
    }
    
}
