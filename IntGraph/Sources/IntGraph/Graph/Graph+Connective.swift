//
//  Graph+Connective.swift
//  
//
//  Created by Nail Sharipov on 06.12.2021.
//

public extension Graph {
    
    @inline(__always)
    var isConective: Bool {
        guard self.nodes.count > 1 else { return true }
        guard let node = nodes.first else { return true }
        let first = node.first
        guard first != .empty else {
            return node.count == 1
        }
        
        var buffer = nodes[first]
        var visited = IntSet(size: size)
        visited.insert(first)
        visited.formUnion(buffer)
        
        var next = IntSet(size: size)
        
        let count = nodes.count
        
        while visited.count < count && !buffer.isEmpty {
            buffer.forEach { index in
                next.formUnion(nodes.buffer[index])
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }

        return visited.count == count
    }

    func connected(a: Int) -> IntSet {
        var buffer = nodes[a]
        var visited = IntSet(size: size)
        visited.insert(a)
        visited.formUnion(buffer)

        var next = IntSet(size: size)
        
        while !buffer.isEmpty {
            buffer.forEach { index in
                next.formUnion(nodes.buffer[index])
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }
        
        return visited
    }
    
    func connected(a: Int, visited: IntSet) -> IntSet {
        var visited = visited
        var buffer = nodes[a].subtracting(visited)
        visited.insert(a)
        visited.formUnion(buffer)

        var next = IntSet(size: size)
        
        while !buffer.isEmpty {
            buffer.forEach { index in
                next.formUnion(nodes.buffer[index])
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }
        
        return visited
    }
}
