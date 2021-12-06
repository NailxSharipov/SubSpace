//
//  File.swift
//  
//
//  Created by Nail Sharipov on 26.11.2021.
//

public struct Graph {

    public private (set) var size: Int
    
    public func isExist(edge: Edge) -> Bool {
        nodes[edge.a].contains(edge.b)
    }
    
    public private (set) var nodes: FixedList<IntSet>
    
    public init(nodes: [Set<Int>]) {
        self.size = nodes.count
        self.nodes = FixedList<IntSet>(size: size, empty: IntSet(size: size))
        for i in 0..<size {
            self.nodes[i] = IntSet(size: size, array: Array(nodes[i]))
        }
    }
    
    public init(edges: [Edge]) {
        var m = -1
        for edge in edges where edge.a > m || edge.b > m {
            m = max(edge.a, edge.b)
        }
        self.size = m + 1
        nodes = FixedList<IntSet>(size: size, empty: IntSet(size: size))
        for edge in edges {
            self.add(edge: edge)
        }
    }
    
    public mutating func add(edge: Edge) {
        nodes[edge.a].insert(edge.b)
        nodes[edge.b].insert(edge.a)
    }
    
    mutating func add(edge: SortedEdge) {
        nodes[edge.a].insert(edge.b)
        nodes[edge.b].insert(edge.a)
    }
    
    public mutating func removeNode(index: Int) {
        nodes.forEachIndex { i in
            nodes[i].remove(index)
        }
        nodes.remove(index)
    }
    
    public mutating func removeAll() {
        nodes.removeAll()
    }
    
}

extension Graph {
    
    var isConective: Bool {
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
    
    func isConnective(a: Int, b: Int) -> Bool {
        guard nodes.contains(a) && nodes.contains(b) else { return false }
        
        var buffer = nodes[a]
        var visited = IntSet(size: size)
        visited.insert(a)
        visited.formUnion(buffer)

        var next = IntSet(size: size)
        
        while !visited.contains(b) && !buffer.isEmpty {
            buffer.forEach { index in
                next.formUnion(nodes.buffer[index])
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }
        
        return visited.contains(b)
    }
    

//    func nodeSubSpaceCount(index: Int) -> Int {
//        let node = self.nodes[index]
//        guard node.count > 2 else {
//            return node.count
//        }
//    }

}

extension Graph: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        nodes.debugDescription
    }
    
    public var description: String {
        nodes.debugDescription
    }
    
}

extension Graph: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self, children: [
            "size": self.size,
            "set": self.nodes.set.sequence,
            "buffer": self.nodes.buffer
        ])
    }
    
    public var edgesDescription: String {
        var result = String()
        self.nodes.set.forEach { a in
            let node = self.nodes[a]
            var indices = [Int]()
            node.forEach { b in
                if a < b {
                    indices.append(b)
                }
            }
            indices.sort()
            if !indices.isEmpty {
                let row = indices.map({ String($0) }).joined(separator: ", ")
                result.append("\(a): \(row)\n")
            }
        }
        return result
    }
    
}
