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
        
        let x0 = 0
        let x1 = n
        
        while i < count {
            edges.removeAll()
            graph.removeAll()
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
            guard graph.isConective && graph.validateVertices(a: x0, b: x1) else {
                continue
            }
            
            let direct = graph.isHamiltonianPathExistDirectSearch(a: x0, b: x1)
            let polynom = graph.isHamiltonianPathExist(a: x0, b: x1)

            if direct != polynom {
                print("index: \(index)")
                print("x: \(x)")
                print("a: \(x0), b: \(x1)")
                print("direct: \(direct)")
                print("polynom: \(polynom)")
                print(graph.edgesDescription)
                print("edges: \(edges)")
            }
        }
        print("\(index) end")
    }
}
