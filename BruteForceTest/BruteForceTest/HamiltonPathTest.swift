//
//  HamiltonPathTest.swift
//  BruteForceTest
//
//  Created by Nail Sharipov on 11.12.2021.
//

import IntGraph
import Foundation

struct HamiltonPathTest {

    private static let logStep: UInt64 = 1 << 18
    
    static func test(index: UInt64, start: UInt64, count: UInt64, n: Int) {
        print("\(index) start")
        var i: UInt64 = 0

        var edges = [Edge]()
        var graph = Graph(size: n + 1)
        
        while i < count {
            var x = start + i
            i += 1
            
            
            if i % logStep == 0 {
                let percent = 100 * Float(i) / Float(count)
                print(String(format: "\(index): %.1f", percent))
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
            
            graph.add(edges: edges)

            guard graph.isConective && graph.validateVertices(a: 0, b: n) else {
                graph.removeAll()
                edges.removeAll()
                continue
            }
            
            let direct = graph.isHamiltonianPathExistDirectSearch(a: 0, b: n)
            let polynom = graph.isHamiltonianPathExist(a: 0, b: n)

            if direct != polynom {
                print("\(index) direct: \(direct)")
                print("\(index) polynom: \(polynom)")
                print(edges)
            }

            graph.removeAll()
            edges.removeAll()
        }
        print("\(index) end")
    }
}
