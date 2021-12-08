//
//  Graph+DirectSearch.swift
//  
//
//  Created by Nail Sharipov on 04.12.2021.
//

public extension Graph {
    
    private struct Solution {
        let last: Int
        let visited: IntSet
        
        init(next: Int, size: Int) {
            self.last = next
            var intSet = IntSet(size: size)
            intSet.insert(next)
            self.visited = intSet
        }
        
        init(next: Int, solution: Solution) {
            self.last = next
            var intSet = solution.visited
            intSet.insert(next)
            self.visited = intSet
        }
    }
    
    func findHamiltonianPathDirectSearch(a: Int, b: Int) -> [Int]? {
        let n = self.size
        
        var solutions = [Solution(next: a, size: n)]
        var buffer = [Solution]()

        var i = 1
        while i < n && !solutions.isEmpty {
            for solution in solutions {
                let node = self.nodes[solution.last]
                node.forEach { x in
                    if !solution.visited.contains(x) {
                        buffer.append(Solution(next: x, solution: solution))
                    }
                }
            }
            
            solutions = buffer
            buffer.removeAll()
            i += 1
        }
        
        if let first = solutions.first, i == n {
            return first.visited.sequence.reversed()
        } else {
            return nil
        }
    }

}
