//
//  GraphDirectTests.swift
//  
//
//  Created by Nail Sharipov on 04.12.2021.
//

import XCTest
@testable import IntGraph

final class GraphDirectTests: XCTestCase {

    func test_hamilton_path_search_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_hamilton_path_search_01() throws {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3)
        ])

        let path = graph.findHamiltonianPathDirectSearch(a: 0, b: 3)
        
        XCTAssertEqual(path, [0, 1, 2, 3])
    }
    
    func test_hamilton_path_search_02() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_hamilton_path_search_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_hamilton_path_search_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }

    func test_hamilton_path_search_05() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
   
}
