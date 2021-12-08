//
//  File.swift
//  
//
//  Created by Nail Sharipov on 07.12.2021.
//

struct ReformedGraph {
    
    struct Bridge {
        enum Shape {
            case circle
            case line
        }
        
        let shape: Shape
        let a: Int
        let b: Int
        let vertices: IntSet
    }
    
    private (set) var graph: Graph
    private var simplifiedEdges: [SortedEdge: Bridge] = [:]

    init(graph: Graph) {
        self.graph = graph
    }

    mutating func exclude2PairNodes(a: Int, b: Int) -> Bool {
        var allVertices = graph.nodes.set
        allVertices.remove(a)
        allVertices.remove(b)

        var bridges = self.findBridgeEdges(indices: allVertices.sequence)

        var nextIndices = IntSet(size: graph.size)
        while !bridges.isEmpty {
            for bridge in bridges {
                switch bridge.shape {
                case .circle:
                    if bridge.vertices.contains(a) && bridge.vertices.contains(b), graph.nodes[a].contains(b) {
                        graph.removeAll()
                        return true
                    } else {
                        return false
                    }
                case .line:
                    let edge = SortedEdge(edge: Edge(a: bridge.a, b: bridge.b))
                    
                    guard simplifiedEdges[edge] == nil else {
                        return false
                    }
                    
                    bridge.vertices.forEach { index in
                        graph.removeNode(index: index)
                    }
                    
                    simplifiedEdges[edge] = bridge
                    graph.add(edge: edge)
                    
                    if edge.a != a && edge.a != b {
                        nextIndices.insert(edge.a)
                    }
                    
                    if edge.b != a && edge.b != b {
                        nextIndices.insert(edge.a)
                    }
                }
            }
            bridges = self.findBridgeEdges(indices: nextIndices.sequence)
        }
        
        return true
    }
    
    
    private func findBridgeEdges(indices: [Int]) -> [Bridge] {
        var result = [Bridge]()
        var visited = IntSet(size: graph.size)
    nextIndex:
        for index in indices where !visited.contains(index) {
            let node = graph.nodes[index]
            if node.count == 2 {
                var vertices = IntSet(size: graph.size)
                vertices.insert(index)
                
                var prev = index
                var ia = node.first
                var a = graph.nodes[ia]
                while a.count == 2 {
                    vertices.insert(ia)
                    let next = a.opposite(index: prev)
                    prev = ia
                    ia = next
                    a = graph.nodes[ia]
                    if ia == index { // find a head, it's a circle
                        result.append(Bridge(shape: .circle, a: index, b: index, vertices: vertices))
                        visited.formUnion(vertices)
                        continue nextIndex
                    }
                }

                prev = index
                var ib = node.first(where: { $0 != node.first })
                var b = graph.nodes[ib]
                while b.count == 2 {
                    vertices.insert(ib)
                    let next = b.opposite(index: ib)
                    prev = ib
                    ib = next
                    b = graph.nodes[ib]
                }
                
                visited.formUnion(vertices)
                let shape: Bridge.Shape = ia == ib ? .circle : .line
                result.append(Bridge(shape: shape, a: ia, b: ib, vertices: vertices))
            }
        }

        return result
    }
    
}

private extension IntSet {

    func opposite(index: Int) -> Int {
        assert(self.count == 2)
        return self.first(where: { $0 != index })
    }
    
}
