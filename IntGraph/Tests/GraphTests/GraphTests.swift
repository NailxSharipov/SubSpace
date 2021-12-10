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
    
    func test_hamiltoPath_00() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 1))
    }
    
    func test_hamiltoPath_01() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 1))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 2))
    }

    func test_hamiltoPath_02() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 2, b: 3))
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 3, b: 1))
    }
    
    func test_hamiltoPath_03() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 1, b: 2)
        ])
        
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 1))
    }
    
    func test_hamiltoPath_04() {
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
    
    func test_hamiltoPath_05() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 1),
            Edge(a: 0, b: 2),
            Edge(a: 0, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 4),
            Edge(a: 3, b: 4),
        ])
        
//        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 4))
//        XCTAssertFalse(graph.isHamiltonianPathExist(a: 1, b: 4))
//        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 3))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 1, b: 2))
        XCTAssertTrue(graph.isHamiltonianPathExist(a: 2, b: 3))
    }
    
    func test_hamiltoPath_06() {
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
    
    func test_hamiltoPath_07() {
        let graph = Graph(edges: [
            Edge(a: 1, b: 0),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 1, b: 4),
            Edge(a: 2, b: 3)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 4))
    }
    
    func test_hamiltoPath_08() {
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
    
    func test_hamiltoPath_09() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])
        
        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
    }

    func test_hamiltoPath_10() {
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
    
    func test_hamiltoPath_11() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 5)
        ])

        XCTAssertFalse(graph.isHamiltonianPathExist(a: 0, b: 5))
    }

    func test_hamiltoPath_12() {
        let graph = Graph(edges: [
            Edge(a: 0, b: 4),
            Edge(a: 1, b: 2),
            Edge(a: 1, b: 3),
            Edge(a: 2, b: 5),
            Edge(a: 3, b: 4)
        ])

        XCTAssertTrue(graph.isHamiltonianPathExist(a: 0, b: 5))
    }
    
    func test_hamiltoPath_13() {
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

    func test_hamiltoPath_14() {
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
    
    func test_hamiltoPath_15() {
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
    
    func test_hamiltoPath_16() {
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

    func test_hamiltoPath_17() {
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
}
