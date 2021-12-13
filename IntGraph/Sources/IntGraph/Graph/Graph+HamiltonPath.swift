//
//  Graph+HamiltonPath.swift
//  
//
//  Created by Nail Sharipov on 27.11.2021.
//

private struct Branch {
    var a: Int
    var b: Int
    var graph: Graph
}

public extension Graph {
    
    func isHamiltonianPathExist(a: Int, b: Int) -> Bool {
        guard self.validateVertices(a: a, b: b) else {
            return false
        }

        let connected = self.connected(a: a)
        guard connected.contains(b) && connected.count == self.size else {
            return false
        }
        
        return discover(a: a, b: b)
    }

    @inline(__always)
    func validateVertices(a: Int, b: Int) -> Bool {
        let hasLeaf = nodes.contains(where: { index, node in
            if index == a || index == b { // special rule for ends
                return node.count == 0
            } else {
                return node.count < 2
            }
        })
        return !hasLeaf
    }
    
    private func discover(a: Int, b: Int) -> Bool {
        var branches = [Branch]()
        branches.append(Branch(a: a, b: b, graph: self))
        
        var buffer = [Branch]()
        
        repeat {
            for var branch in branches {
                let result = branch.discover()
                switch result {
                case .valid:
                    continue
                case .notValid:
                    return false
                case .subBranches(let branches):
                    buffer.append(contentsOf: branches)
                }
            }
            branches = buffer
            buffer.removeAll()
        } while !branches.isEmpty

        return true
    }
}

private extension Branch {
    
    enum Result {
        case valid
        case notValid
        case subBranches([Branch])
    }
    
    mutating func discover() -> Result {
        guard graph.validateVertices(a: a, b: b) else {
            return .notValid
        }
        
        guard self.removeEnds() else {
            return .notValid
        }
        
        guard graph.nodes.count > 3 else {
            return .valid
        }

        let endsResult = self.discoverEnds()
        switch endsResult {
        case .valid:
            break
        default:
            return endsResult
        }

        var indices = [Int]()
        graph.nodes.forEachIndex { i in
            if graph.nodes[i].count > 2 && a != i && b != i {
                indices.append(i)
            }
        }
        
        guard !indices.isEmpty else {
            return .valid
        }

        let endResult = self.discoverSide(indices: indices)
        switch endResult {
        case .valid:
            break
        default:
            return endResult
        }

        let middleResult = self.discoverMiddle(indices: indices)
        switch middleResult {
        case .valid:
            break
        default:
            return middleResult
        }

        return .valid
    }
    
    func discoverEnds() -> Result {
        let subSets = graph.split(a: a, b: b)
        guard subSets.count <= 1 else {
            return .notValid
        }
        
        guard let subSet = subSets.first else {
            return .valid
        }

        struct Spike {
            let isA: Bool
            let isB: Bool
            let index: Int
            let neighbor: Int
        }
        
        var spikes = [Spike]()
        
        subSet.forEach { i in
            let node = graph.nodes[i]
            var degree = node.count
            
            if degree <= 3 {
                let isA = node.contains(a)
                let isB = node.contains(b)
                
                if isA {
                    degree -= 1
                }

                if isB {
                    degree -= 1
                }
                assert(degree != 0)

                if degree == 1 {
                    let neighbor = node.first(where: { $0 != a && $0 != b })
                    spikes.append(Spike(isA: isA, isB: isB, index: i, neighbor: neighbor))
                }
            }
        }
        
        guard spikes.count <= 2 else {
            return .notValid
        }

        switch spikes.count {
        case 0:
            return .valid
        case 1:
            let spike = spikes[0]
            assert(spike.isA || spike.isB)
            var subGraph = self.graph
            subGraph.removeNode(index: spike.index)
           
            if spike.isA && spike.isB {
                // merge all into a
                graph.nodes[a].forEach { i in
                    if i != spike.index && i != b {
                        subGraph.add(edge: Edge(a: a, b: i))
                    }
                }
                
                graph.nodes[b].forEach { i in
                    if i != spike.index && i != a {
                        subGraph.add(edge: Edge(a: a, b: i))
                    }
                }
                
                if subGraph.nodes.count > 3 {
                    return .subBranches([Branch(a: a, b: spike.neighbor, graph: subGraph)])
                } else {
                    return .valid
                }
            } else if spike.isA {
                subGraph.removeNode(index: a)
                if subGraph.nodes.count > 3 {
                    return .subBranches([Branch(a: spike.neighbor, b: b, graph: subGraph)])
                } else {
                    return .valid
                }
            } else {
                assert(spike.isB)
                subGraph.removeNode(index: b)
                if subGraph.nodes.count > 3 {
                    return .subBranches([Branch(a: b, b: spike.neighbor, graph: subGraph)])
                } else {
                    return .valid
                }
            }
        case 2:
            let s0 = spikes[0]
            let s1 = spikes[1]
            
            guard (s0.isA || s0.isB) && (s1.isA || s1.isB) else {
                return .notValid
            }
            
            var subGraph = self.graph
            subGraph.removeNode(index: a)
            subGraph.removeNode(index: b)
            subGraph.removeNode(index: s0.index)
            subGraph.removeNode(index: s1.index)

            if subGraph.nodes.count > 3 {
                return .subBranches([Branch(a: s0.neighbor, b: s1.neighbor, graph: subGraph)])
            } else {
                return .valid
            }
        default:
            return .notValid
        }
    }
    
    func discoverSide(indices: [Int]) -> Result {
        for i in indices {
            let aib = self.split(a: a, b: b, x: i)
            switch aib {
            case .valid:
                break
            default:
                return aib
            }
            
            let bia = self.split(a: b, b: a, x: i)
            switch bia {
            case .valid:
                break
            default:
                return bia
            }
        }

        return .valid
    }
    
    @inline(__always)
    private func split(a: Int, b: Int, x: Int) -> Result {
        let subSets = graph.split(a: a, b: x)
        switch subSets.count {
        case 1:
            return .valid
        case 2:
            guard let bIndex = subSets.firstIndex(where: { $0.contains(b) }) else {
                return .notValid
            }

            var branches = [Branch]()
            
            // a - x
            let bSubset = subSets[bIndex]
            var aSubGraph = graph
            aSubGraph.remove(nodes: bSubset)
            
            if aSubGraph.nodes.count > 3 {
                branches.append(Branch(a: a, b: x, graph: aSubGraph))
            }
            
            // x - b
            let aIndex = (bIndex + 1) % 2
            let aSubset = subSets[aIndex]
            var bSubGraph = graph
            bSubGraph.remove(nodes: aSubset)
            bSubGraph.removeNode(index: a)
            
            if bSubGraph.nodes.count > 3 {
                branches.append(Branch(a: x, b: b, graph: bSubGraph))
            }

            if branches.isEmpty {
                return .valid
            } else {
                return .subBranches(branches)
            }
        default:
            return .notValid
        }
    }
    
    private func discoverMiddle(indices: [Int]) -> Result {
        let n = indices.count
        for i in 0..<n - 1 {
            let x0 = indices[i]
            for j in i + 1..<n {
                let x1 = indices[j]
                let subSets = graph.split(a: x0, b: x1)
                switch subSets.count {
                case 1:
                    return .valid
                case 2, 3:
                    var mIndex = Int.empty
                    var aIndex = Int.empty
                    var bIndex = Int.empty
                    for index in 0..<subSets.count {
                        let subSet = subSets[index]
                        let isA = subSet.contains(a)
                        let isB = subSet.contains(b)
                        
                        if isA {
                            aIndex = index
                        } else if isB {
                            bIndex = index
                        } else {
                            if mIndex == .empty {
                                mIndex = index
                            } else {
                                // must be only one
                                return .notValid
                            }
                        }
                    }
                    
                    var branches = [Branch]()
                    
                    if mIndex != .empty {
                        // middle graph
                        var mSubGraph = graph
                        
                        if bIndex != .empty {
                            mSubGraph.remove(nodes: subSets[bIndex])
                        }
                        if aIndex != .empty {
                            mSubGraph.remove(nodes: subSets[aIndex])
                        }
                        
                        if mSubGraph.nodes.count > 3 {
                            branches.append(Branch(a: x0, b: x1, graph: mSubGraph))
                        }
                    }
                    
                    let x = x0
                    if aIndex != .empty && subSets[aIndex].count > 2 {
                        // a graph
                        
                        var aSubGraph = graph
                        if bIndex != .empty {
                            aSubGraph.remove(nodes: subSets[bIndex])
                        }
                        if mIndex != .empty {
                            aSubGraph.remove(nodes: subSets[mIndex])
                        }
                        aSubGraph.removeNode(index: x0)
                        aSubGraph.removeNode(index: x1)

                        graph.nodes[x0].forEach { index in
                            if aSubGraph.nodes.contains(index) {
                                aSubGraph.add(edge: Edge(a: x, b: index))
                            }
                        }
                        
                        graph.nodes[x1].forEach { index in
                            if aSubGraph.nodes.contains(index) {
                                aSubGraph.add(edge: Edge(a: x, b: index))
                            }
                        }
                        
                        if aSubGraph.nodes.count > 3 {
                            branches.append(Branch(a: a, b: x, graph: aSubGraph))
                        }
                    }
                    
                    if bIndex != .empty && subSets[bIndex].count > 2 {
                        // b graph
                        
                        var bSubGraph = graph
                        if aIndex != .empty {
                            bSubGraph.remove(nodes: subSets[aIndex])
                        }
                        if mIndex != .empty {
                            bSubGraph.remove(nodes: subSets[mIndex])
                        }
                        bSubGraph.removeNode(index: x0)
                        bSubGraph.removeNode(index: x1)

                        graph.nodes[x0].forEach { index in
                            if bSubGraph.nodes.contains(index) {
                                bSubGraph.add(edge: Edge(a: x, b: index))
                            }
                        }
                        
                        graph.nodes[x1].forEach { index in
                            if bSubGraph.nodes.contains(index) {
                                bSubGraph.add(edge: Edge(a: x, b: index))
                            }
                        }
                        
                        if bSubGraph.nodes.count > 3 {
                            branches.append(Branch(a: b, b: x, graph: bSubGraph))
                        }
                        
                    }
                    
                    if !branches.isEmpty {
                        return .subBranches(branches)
                    }
                default:
                    return .notValid
                }
            }
        }

        return .valid
    }
    
    
    func discover(indices: [Int]) -> Result {
        
        return .valid
    }

    private mutating func removeEnds() -> Bool {
        var ax = a
        var node = graph.nodes[ax]
        while node.count < 2 {
            if node.first == b {
                return graph.nodes.count == 2
            }
            graph.removeNode(index: ax)
            ax = node.first
            node = graph.nodes[ax]
        }
        if ax != a {
            a = ax
        }
        
        var bx = b
        node = graph.nodes[bx]
        while node.count < 2 {
            if node.first == a {
                return graph.nodes.count == 2
            }
            graph.removeNode(index: bx)
            bx = node.first
            node = graph.nodes[bx]
        }
        if bx != b {
            b = bx
        }
        
        return true
    }

}
