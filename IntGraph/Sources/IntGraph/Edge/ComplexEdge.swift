//
//  ComplexEdge.swift
//  
//
//  Created by Nail Sharipov on 27.11.2021.
//

struct ComplexEdge {
    
    private (set) var edge: SortedEdge
    private (set) var path: [Int]

    init(edge: Edge) {
        self.edge = SortedEdge(edge: edge)
        self.path = [Int]()
    }
    
//    mutating func connect(edge: Edge) -> EdgeConnection {
//        let newEdge = SortedEdge(edge: edge)
//        
//        guard newEdge.a == edge.a || newEdge.b == edge.b else {
//            return .notMatch
//        }
//        
//        guard newEdge.a != edge.a && newEdge.b != edge.b else {
//            return .sameEnds
//        }
//        
//        if edge.a = newEdge.a {
//            if newEdge.b < edge.b {
//                path.insert(edge.a, at: 0)
//                edge = SortedEdge(a: newEdge.b, b: edge.b)
//            } else {
//                path.reverse()
//                path.append(edge.a)
//                edge = SortedEdge(a: edge.b, b: newEdge.b)
//            }
//        } else {
//            if newEdge.a < edge.a {
//                path.insert(edge.a, at: 0)
//                edge = SortedEdge(a: newEdge.b, b: edge.b)
//            } else {
//                path.append(edge.b)
//                edge = SortedEdge(a: edge.b, b: newEdge.b)
//            }
//        }
//        
//        return .connected
//    }
    
}
