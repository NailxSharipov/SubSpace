//
//  Graph+DirectSearch.swift
//  
//
//  Created by Nail Sharipov on 04.12.2021.
//

public extension Graph {
    
    private struct Solution {
        let last: Int
        let visited: UInt64
        
        init(next: Int, size: Int) {
            self.last = next
            self.visited = UInt64(0).setBit(index: next)
        }
        
        init(next: Int, solution: Solution) {
            self.last = next
            self.visited = solution.visited.setBit(index: next)
        }
    }

    func isHamiltonianPathExistDirectSearch(a: Int, b: Int) -> Bool {
        let n = self.size
        
        var solutions = [Solution(next: a, size: n)]
        var buffer = [Solution]()

        var i = 2
        while i < n && !solutions.isEmpty {
            for solution in solutions {
                let node = self.nodes[solution.last]
                node.forEach { x in
                    if x != b && !solution.visited.isBit(index: x) {
                        buffer.append(Solution(next: x, solution: solution))
                    }
                }
            }
            
            solutions = buffer
            buffer.removeAll()
            i += 1
        }
        
        guard i == n && !solutions.isEmpty else {
            return false
        }
        
        for solution in solutions {
            if nodes[solution.last].contains(b) {
                return true
            }
        }
        return false
    }
    
}

private extension UInt64 {

    @inline(__always)
    func isBit(index: Int) -> Bool {
        let bit: UInt64 = (1 << index)
        return bit & self == bit
    }
    
    @inline(__always)
    func setBit(index: Int) -> UInt64 {
        let bit: UInt64 = (1 << index)
        return self | bit
    }
    
    @inline(__always)
    func clearBit(index: Int) -> UInt64 {
        let bit: UInt64 = (1 << index)
        return self & (UInt64.max &- bit)
    }
}
