//
//  GraphDirectTests.swift
//  
//
//  Created by Nail Sharipov on 04.12.2021.
//

import XCTest
@testable import IntGraph

final class GraphDirectTests: XCTestCase {

    func test_simple_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 1))
    }
    
    func test_simple_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 1))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 2))
    }

    func test_simple_02() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 2, b: 3))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 3, b: 1))
    }
    
    func test_simple_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 1))
    }
    
    func test_simple_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 2, b: 3))
    }
    
    func test_simple_05() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 4),
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 2, b: 3))
    }
    
    func test_simple_06() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 1, b: 3))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 2))
    }
    
    func test_simple_07() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 4))
    }
    
    func test_small_00() {
        let graph = Graph(edges: [
            Edge(a: 1, b: 0),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 1, b: 5),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }

    func test_small_02() {
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
    
    func test_small_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }

    func test_small_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_05() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }

    func test_small_06() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 5)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_07() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 5)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_08() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4),
            Edge(a: 4, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_09() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 5),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 4)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_small_10() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 5),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 4),
            Edge(a: 3, b: 5),
            Edge(a: 5, b: 6)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 6))
    }

    func test_small_11() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 5),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4),
            Edge(a: 5, b: 6)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 6))
    }
    
    func test_small_12() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4),
            Edge(a: 4, b: 5),
            Edge(a: 5, b: 6)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 6))
    }
    
    func test_small_13() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 6),
            Edge(a: 4, b: 5),
            Edge(a: 5, b: 6)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 6))
    }

    func test_medium_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 6),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 4),
            Edge(a: 4, b: 5),
            Edge(a: 6, b: 7),
            Edge(a: 6, b: 8),
            Edge(a: 7, b: 8),
            Edge(a: 7, b: 9),
            Edge(a: 8, b: 9),
            Edge(a: 9, b: 5),
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 5))
    }
    
    func test_Herschel_graph_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 0, b: 6),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),
            Edge(a: 4, b: 10),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            Edge(a: 6, b: 10),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 6),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),
            Edge(a: 4, b: 10),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            Edge(a: 6, b: 10),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_02() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),
            Edge(a: 4, b: 10),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            Edge(a: 6, b: 10),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 0, b: 6),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            Edge(a: 6, b: 10),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            Edge(a: 0, b: 6),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),
            Edge(a: 4, b: 10),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_05() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 6),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),
            Edge(a: 4, b: 10),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
    
    func test_Herschel_graph_06() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 4),
            
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            
            Edge(a: 2, b: 4),
            Edge(a: 2, b: 5),
            
            Edge(a: 3, b: 5),
            Edge(a: 3, b: 6),
            
            Edge(a: 4, b: 7),

            Edge(a: 5, b: 7),
            Edge(a: 5, b: 8),
            
            Edge(a: 6, b: 8),
            Edge(a: 6, b: 10),
            
            Edge(a: 7, b: 9),
            
            Edge(a: 8, b: 9),
            
            Edge(a: 9, b: 10)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExistDirectSearch(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExistDirectSearch(a: 4, b: 6))
    }
   
}
