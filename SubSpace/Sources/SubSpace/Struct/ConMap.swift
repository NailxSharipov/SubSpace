//
//  ConMap.swift
//  
//
//  Created by Nail Sharipov on 05.11.2021.
//

import Foundation

public struct ConMap {
    
    private var array: [ConMatrix?]
    private let size: Int
    
    @inline(__always)
    public subscript(i: Int, j: Int) -> ConMatrix? {
        get {
            array[index(i, j)]
        }
        set {
            array[index(i, j)] = newValue
        }
    }
    
    @inline(__always)
    private func index(_ i: Int, _ j: Int) -> Int {
        i * size + j
    }
    
    public struct Node {
        public let index: Int
        public let pos: IntSet
    }
    
    public var nodes: [Node] {
        var result = [Node]()
        for i in 0..<size {
            var pos = IntSet(size: size)
            for j in 0..<size {
                if self[i, j] != nil {
                    pos.insert(j)
                }
            }
            result.append(Node(index: i, pos: pos))
        }
        return result
    }
    
    public var nodeSets: [IntSet] {
        var result = [IntSet]()
        for i in 0..<size {
            var set = IntSet(size: size)
            for j in 0..<size {
                if self[i, j] != nil {
                    set.insert(j)
                }
            }
            result.append(set)
        }
        return result
    }
    
    public init(size: Int) {
        self.size = size
        self.array = Array<ConMatrix?>(repeating: nil, count: size * size)
    }
    
    public mutating func excludeCross(matrix: AdMatrix) {
        for a in 0..<size {
            for b in 0..<size where a != b {
                var abMx = ConMatrix(size: size)
                for c in 0..<size {
                    if c != a && c != b {
                        for d in 0..<size where d != a && d != b && d != c {
                            if !matrix.isCross(a: a, b: b, c: c, d: d) {
                                abMx[c, d] = true
                            }
                        }
                    } else {
                        let x = c == a ? a : b
                        for d in 0..<size where d != a && d != b {
                            abMx[x, d] = true
                            abMx[d, x] = true
                        }
                    }
                }
                self[a, b] = abMx
            }
        }
    }
    
    public mutating func excludeChordes() {
        var chordes = [Edge]()
        var existed = Set<Edge>()
        
        for a in 0..<size {
            for b in 0..<size where a != b {
                if let abMx = self[a, b] {
                    let count = abMx.visitedCount(a: a, b: b)
                    if count != size {
                        self[a, b] = nil
                        chordes.append(Edge(a: a, b: b))
                    } else {
                        existed.insert(Edge(a: a, b: b))
                    }
                }
            }
        }

        var count = 0
        
        while !chordes.isEmpty {
            var newChordes = [Edge]()
            
            for edge in existed {
                if var abMx = self[edge.a, edge.b] {
                    var modified = false
                    for chord in chordes {
                        if abMx[chord.a, chord.b] {
                            abMx[chord.a, chord.b] = false
                            modified = true
                        }
                    }
                    
                    if modified {
                        let count = abMx.visitedCount(a: edge.a, b: edge.b)
                        if count != size {
                            self[edge.a, edge.b] = nil
                            newChordes.append(edge)
                            existed.remove(edge)
                        } else {
                            self[edge.a, edge.b] = abMx
                        }
                    }
                }
            }

            count += 1
            
            chordes = newChordes
        }
        
        if count > 1 {
            print(count)
        }
    }


    public func findContour() -> [Int] {
        let excludes = self.findExlude()

        var result = [Int]()
        let nodes = self.nodes
        var set = IntSet(size: size, Array(0..<size))
        var visited = excludes
        
        set.subtract(excludes)

        var next = set.removeFirst()
        result.append(next)
        visited.insert(next)
        
        repeat {
            let pos = nodes[next].pos.subtracting(visited)
            if let first = pos.first {
                result.append(first)
                visited.insert(first)
                set.remove(first)
                next = first
            } else {
                break
            }

        } while !set.isEmpty


        return result
    }
    
    
    public func findExlude() -> IntSet {
        var nodes = self.nodeSets

        var exclude = [Int]()
        while nodes.first(where: { $0.count > 2 }) != nil {
            
            var max = 0
            for s in nodes where max < s.count {
                max = s.count
            }
            
            var remove = [Int]()
            for i in 0..<size where nodes[i].count == max {
                exclude.append(i)
                remove.append(i)
                nodes[i].removeAll()
            }
            
            for i in remove {
                for j in 0..<size where nodes[j].count > 0 {
                    nodes[j].remove(i)
                }
            }
            
        }

        return IntSet(size: size, exclude)
    }
    
    struct MaxConnections {
        let count: Int
        let indices: [Int]
    }
    
    func findMaxConnections() -> MaxConnections {
        var indices = [Int]()
        var max = 0
        for i in 0..<size {
            var count = 0
            for j in 0..<size where self[i, j] != nil {
                count += 1
            }
            if max == count {
                indices.append(i)
            } else if max < count {
                max = count
                indices = [i]
            }
        }
        
        return MaxConnections(count: max, indices: indices)
    }
    
}

private extension Array where Element == IntSet {
    
    func isEqual(count: Int) -> Bool {
        for s in self {
            let sCount = s.count
            if sCount != 0 && sCount != count {
                return false
            }
        }
        
        return true
    }
    
}
