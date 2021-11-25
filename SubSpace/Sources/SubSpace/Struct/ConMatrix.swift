//
//  File.swift
//
//
//  Created by Nail Sharipov on 05.11.2021.
//

public struct ConMatrix {
    
    private var array: [IntSet]
    
    @inline(__always)
    public subscript(i: Int, j: Int) -> Bool {
        get {
            array[i].contains(j)
        }
        set {
            if newValue {
                array[i].insert(j)
            } else {
                array[i].remove(j)
            }
        }
    }
    
    @inline(__always)
    private subscript(i: Int) -> IntSet {
        array[i]
    }

    init(size: Int) {
        array = [IntSet](repeating: IntSet(size: size), count: size)
    }
    
    init(array: [IntSet]) {
        self.array = array
    }
    
    func intersect(matrix: ConMatrix) -> ConMatrix {
        let size = array.count
        var result = [IntSet]()
        for i in 0..<size {
            result.append(self[i].intersection(matrix[i]))
        }
        return ConMatrix(array: result)
    }
    

    @inline(__always)
    func visitedCount(a: Int, b: Int) -> Int {
        let size = array.count
        var visited = IntSet(size: size, [a, b])
        guard let first = self[a].subtracting(visited).first else {
            return 0
        }
        
        var mask = self[first].subtracting(visited)
        visited.insert(first)

        while !mask.isEmpty {
            visited.formUnion(mask)
            var nextMask = IntSet(size: size)
            for c in mask.sequence {
                nextMask.formUnion(self[c])
            }
            mask = nextMask.subtracting(visited)
        }

        return visited.count
    }
    
    @inline(__always)
    func visited(a: Int, b: Int, i: Int) -> IntSet {
        let size = array.count
        var visited = IntSet(size: size, [a, b, i])
        guard let first = self[a].first(where: { !visited.contains($0) }) else {
            return visited
        }
        
        var mask = self[first].subtracting(visited)
        visited.insert(first)

        while !mask.isEmpty {
            visited.formUnion(mask)
            var nextMask = IntSet(size: size)
            for c in mask.sequence {
                nextMask.formUnion(self[c])
            }
            mask = nextMask.subtracting(visited)
        }

        return visited
    }
}

extension ConMatrix: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        return self.description
    }
    
    public var description: String {
        var result = String()
        for i in 0..<array.count {
            result.append("\(i): \(array[i])")
            if i + 1 < array.count {
                result.append("  ")
            }
        }
        return result
    }
    
}
