//
//  SortedEdge.swift
//  
//
//  Created by Nail Sharipov on 27.11.2021.
//

struct SortedEdge {
    
    private (set) var a: Int
    private (set) var b: Int
    
    init(edge: Edge) {
        if edge.a > edge.b {
            self.a = edge.b
            self.b = edge.a
        } else {
            self.a = edge.a
            self.b = edge.b
        }
    }
    
    init(a: Int, b: Int) {
        assert(a < b)
        self.a = a
        self.b = b
    }
    
    init(array: [Int]) {
        assert(array.count == 2)
        let a0 = array[0]
        let a1 = array[1]
        if a0 > a1 {
            self.a = a1
            self.b = a0
        } else {
            self.a = a0
            self.b = a1
        }
    }
//
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
//        if edge.a == newEdge.a {
//            self.ed
//            if newEdge.b < edge.b {
//                edge = SortedEdge(a: newEdge.b, b: edge.b)
//            } else {
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

extension SortedEdge: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
    
}
