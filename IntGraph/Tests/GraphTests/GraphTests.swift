import XCTest
@testable import IntGraph

final class GraphTests: XCTestCase {

    func test_basic() throws {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3),
            Edge(a: 3, b: 0)
        ])

        XCTAssertEqual(graph.size, 4)

        XCTAssertTrue(graph.isExist(edge: Edge(a: 0, b: 1)))
        XCTAssertTrue(graph.isExist(edge: Edge(a: 1, b: 0)))
        
        XCTAssertTrue(graph.isExist(edge: Edge(a: 1, b: 2)))
        XCTAssertTrue(graph.isExist(edge: Edge(a: 2, b: 1)))
        
        XCTAssertTrue(graph.isExist(edge: Edge(a: 2, b: 3)))
        XCTAssertTrue(graph.isExist(edge: Edge(a: 3, b: 2)))
        
        XCTAssertTrue(graph.isExist(edge: Edge(a: 3, b: 0)))
        XCTAssertTrue(graph.isExist(edge: Edge(a: 0, b: 3)))
    }
    
    func test_connective_00() {
        var graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3),
            Edge(a: 3, b: 0)
        ])
        
        XCTAssertTrue(graph.isConective)
        
        graph.removeNode(index: 0)
        graph.removeNode(index: 2)
        XCTAssertFalse(graph.isConective)
    }
    
    func test_connective_01() {
        var graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3),
            Edge(a: 3, b: 0)
        ])
        
        XCTAssertTrue(graph.isConective)
        
        graph.removeNode(index: 0)
        graph.removeNode(index: 2)
        XCTAssertTrue(graph.isConective)
    }
    
    func test_simple_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 1))
    }
    
    func test_simple_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 1))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 2))
    }

    func test_simple_02() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 2, b: 3))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 3, b: 1))
    }
    
    func test_simple_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 1))
    }
    
    func test_simple_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 2, b: 3))
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
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 2, b: 3))
    }
    
    func test_simple_06() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 4))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 3))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 2))
    }
    
    func test_simple_07() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 4))
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
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
    }
    
    func test_small_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
    }
    
    func test_small_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
    }

    func test_small_04() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 6))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 6))
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

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 6))
    }
    
    func test_small_13() {
//        let graph = Graph(edges: [
//            Edge(a: 0, b: 1),
//            Edge(a: 0, b: 3),
//            Edge(a: 1, b: 3),
//            Edge(a: 1, b: 4),
//            Edge(a: 2, b: 3),
//            Edge(a: 2, b: 5),
//            Edge(a: 3, b: 6),
//            Edge(a: 4, b: 5),
//            Edge(a: 5, b: 6)
//        ])

        let graph = Graph(edges: [
            Edge(a: 0, b: 3),
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 6),
            Edge(a: 4, b: 5),
            Edge(a: 5, b: 6)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 6))
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
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
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
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 10))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 4, b: 6))
    }
}
