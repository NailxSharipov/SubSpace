//
//  Graph.swift
//  
//
//  Created by Nail Sharipov on 26.11.2021.
//

public struct Graph {

    public private (set) var size: Int
    
    @inline(__always)
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
    
    public init(size: Int) {
        self.size = size
        self.nodes = FixedList<IntSet>(size: size, empty: IntSet(size: size))
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
    
    public init(edges: [Edge], size: Int) {
        self.size = size
        nodes = FixedList<IntSet>(size: size, empty: IntSet(size: size))
        for edge in edges {
            self.add(edge: edge)
        }
    }
    
    @inline(__always)
    public mutating func add(edge: Edge) {
        nodes[edge.a].insert(edge.b)
        nodes[edge.b].insert(edge.a)
    }
    
    @inline(__always)
    mutating func add(edge: SortedEdge) {
        nodes[edge.a].insert(edge.b)
        nodes[edge.b].insert(edge.a)
    }
    
    @inline(__always)
    public mutating func add(edges: [Edge]) {
        for edge in edges {
            self.add(edge: edge)
        }
    }
    
    @inline(__always)
    public mutating func removeNode(index: Int) {
        nodes.forEachIndex { i in
            nodes[i].remove(index)
        }
        nodes.remove(index)
    }
    
    @inline(__always)
    public mutating func remove(nodes set: IntSet) {
        nodes.forEachIndex { i in
            nodes[i].subtract(set)
        }
        set.forEach { i in
            nodes.remove(i)
        }
    }
    
    @inline(__always)
    public mutating func removeAll() {
        nodes.removeAll()
    }
    
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
                result.append("(\(a): \(row)) ")
            }
        }
        return result
    }
    
}
