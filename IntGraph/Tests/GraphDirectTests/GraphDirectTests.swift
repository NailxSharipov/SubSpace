//
//  GraphDirectTests.swift
//  
//
//  Created by Nail Sharipov on 04.12.2021.
//

import XCTest
@testable import IntGraph

final class GraphDirectTests: XCTestCase {

    func test_hamilton_path_search() throws {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3)
        ])

        let path = graph.findHamiltonianPathDirectSearch(a: 0, b: 3)
        
        XCTAssertEqual(path, [0, 1, 2, 3])
    }
    
    func test_hamilton_path_search_random() throws {
        let size = 10
        for _ in 0..<1000 {
            var edges = [Edge]()
            
            for _ in 0...25 {
                let a = Int.random(in: 0..<size)
                let b = Int.random(in: 0..<size)
                edges.append(Edge(a: a, b: b))
            }
            
            let graph = Graph(edges: edges)
            if let path = graph.findHamiltonianPathDirectSearch(a: 0, b: size - 1) {
                XCTAssertEqual(Set(path).count, size)
            }
        }
    }
    
}
