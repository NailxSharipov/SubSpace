//
//  main.swift
//  BruteForceTest
//
//  Created by Nail Sharipov on 09.12.2021.
//

import IntGraph

print("start")

let n = 6
let max = 1 << ((n - 1) * n + 1)

var counter: UInt64 = 0
var skiped = 0

var edges = [Edge]()
while counter < max {
    
    var x = counter
    counter += 1
    
    if counter % 100_000 == 0 {
        print(100 * Float(counter) / Float(max))
    }
    
    for a in 0..<n {
        let len = n - a
        let bitMask: UInt64 = (1 << len) - 1
        var value = x & bitMask
        while value > 0 {
            let b = value.trailingZeroBitCount + 1
            value = value >> b
            edges.append(.init(a: a, b: b + a))
        }
        x = x >> n
    }
    
    let graph = Graph(edges: edges, size: n + 1)

    guard graph.isConective && graph.validateVertices(a: 0, b: n) else {
        skiped += 1
        continue
    }
    
    let direct = graph.isHamiltonianPathExistDirectSearch(a: 0, b: n)
    let polynom = graph.isHamiltonianPathExist(a: 0, b: n)

    if direct != polynom {
        print("direct: \(direct)")
        print("polynom: \(polynom)")
        print(edges)
    }

    edges.removeAll()
}

print("total: \(max), skiped: \(skiped)")

extension UInt64 {
    @inline(__always)
    func isBit(index: Int) -> Bool {
        let bit: UInt64 = (1 << index)
        return bit & self == bit
    }
    
    func bitDescription(_ length: Int = UInt64.bitWidth) -> String {
        var result = String()
        let last = length &- 1
        for i in 0...last {
            if self.isBit(index: last &- i) {
                result.append("1")
            } else {
                result.append("0")
            }
        }
        return result
    }
}
