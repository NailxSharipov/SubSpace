//
//  EquivalentGraph.swift
//  
//
//  Created by Nail Sharipov on 27.11.2021.
//

public extension Graph {

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
    
    func isHamiltonianPathExist(a: Int, b: Int) -> Bool {
        guard self.isConnective(a: a, b: b) else {
            return false
        }

        guard self.isHamiltonianQualifiedVertices(a: a, b: b) else {
            return false
        }

        var graph = self
        guard graph.simplify(a: a, b: b) else {
            return false
        }

        return true
    }
    
    func isHamiltonianQualifiedVertices(a: Int, b: Int) -> Bool {
        let index = nodes.firstIndex(where: { index, node in
            node.count < 2 && index != a && index != b
        })
        return index == .empty
    }

    private mutating func simplify(a: Int, b: Int) -> Bool {
        var allVertices = self.nodes.set
        allVertices.remove(a)
        allVertices.remove(b)

        var bridges = self.findBridgeEdges(indices: allVertices.sequence)
        
        var removedEdges = Set<SortedEdge>()
        var nextIndices = IntSet(size: size)
        while !bridges.isEmpty {
            for bridge in bridges {
                switch bridge.shape {
                case .circle:
                    if bridge.vertices.contains(a) && bridge.vertices.contains(b), nodes[a].contains(b) {
                        self.removeAll()
                        return true
                    } else {
                        return false
                    }
                case .line:
                    let edge = SortedEdge(edge: Edge(a: bridge.a, b: bridge.b))
                    
                    guard !removedEdges.contains(edge) else {
                        return false
                    }
                    
                    bridge.vertices.forEach { index in
                        self.removeNode(index: index)
                    }
                    
                    removedEdges.insert(edge)
                    self.add(edge: edge)
                    
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
    
    private mutating func findBridgeEdges(indices: [Int]) -> [Bridge] {
        var result = [Bridge]()
        var visited = IntSet(size: size)
    nextIndex:
        for index in indices where !visited.contains(index) {
            let node = nodes[index]
            if node.count == 2 {
                var vertices = IntSet(size: size)
                vertices.insert(index)
                
                var prev = index
                var ia = node.first
                var a = nodes[ia]
                while a.count == 2 {
                    vertices.insert(ia)
                    let next = a.opposite(index: prev)
                    prev = ia
                    ia = next
                    a = nodes[ia]
                    if ia == index { // find a head, it's a circle
                        result.append(Bridge(shape: .circle, a: index, b: index, vertices: vertices))
                        visited.formUnion(vertices)
                        continue nextIndex
                    }
                }

                prev = index
                var ib = node.first(where: { $0 != node.first })
                var b = nodes[ib]
                while b.count == 2 {
                    vertices.insert(ib)
                    let next = b.opposite(index: ib)
                    prev = ib
                    ib = next
                    b = nodes[ib]
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
