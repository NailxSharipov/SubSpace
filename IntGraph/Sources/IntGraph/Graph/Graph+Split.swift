//
//  Graph+Split.swift
//  
//
//  Created by Nail Sharipov on 06.12.2021.
//

extension Graph {

    public func split(node: Int) -> [IntSet] {
        var subGraph = self
        subGraph.removeNode(index: node)

        var result = [IntSet]()
        
        var indices = subGraph.nodes.set
        
        while !indices.isEmpty {
            let i = indices.first
            let subIndices = subGraph.connected(a: i)
            indices.subtract(subIndices)
            subGraph.remove(nodes: subIndices)

            result.append(subIndices)
        }

        return result
    }

    public func split(a: Int, b: Int) -> [IntSet] {
        var subGraph = self
        subGraph.removeNode(index: a)
        subGraph.removeNode(index: b)

        var result = [IntSet]()
        
        var indices = subGraph.nodes.set
        
        while !indices.isEmpty {
            let i = indices.first
            let subIndices = subGraph.connected(a: i)
            indices.subtract(subIndices)
            subGraph.remove(nodes: subIndices)

            result.append(subIndices)
        }

        return result
    }
    
}
