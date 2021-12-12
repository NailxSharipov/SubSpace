//
//  main.swift
//  RandomTest
//
//  Created by Nail Sharipov on 12.12.2021.
//

import Foundation
import IntGraph

let n = 100
let size = 200

var path = [Edge]()

for i in 1..<size {
    path.append(Edge(a: i - 1, b: i))
}

var random = Random()

let t0 = Date()

for i in 0..<n {
    var graph = Graph(edges: path, size: size)
    for _ in 0..<10_000 {
        let a = random.number(max: size)
        let b = random.number(max: size)
        if a != b {
            graph.add(edge: Edge(a: a, b: b))
        }
    }
    
//    if !graph.isHamiltonianPathExistDirectSearch(a: 0, b: size - 1) {
    if !graph.isHamiltonianPathExist(a: 0, b: size - 1) {
        print(graph.edgesDescription)
    }

    debugPrint(i)
}

let t1 = Date()

print("tottal time: \(t1.timeIntervalSince(t0))")
// 18.78
