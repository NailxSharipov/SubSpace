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

        self.removeEnds()

        guard graph.nodes.count > 2 else {
            return .valid
        }
        
        guard a != b else {
            return .notValid
        }
        
        guard self.discoverEnds() else {
            return .notValid
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
    
    func discoverEnds() -> Bool {
        let subSets = graph.split(a: a, b: b)
        guard subSets.count <= 1 else {
            return false
        }
        
        guard subSets.count == 1 else {
            return true
        }
        
        var isConainA = false
        var isConainB = false
        
        subSets[0].forEach { i in
            let node = graph.nodes[i]
            isConainA = isConainA || node.contains(a)
            isConainB = isConainB || node.contains(b)
        }

        return isConainA && isConainB
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
            
//            if graph.nodes.count > 3 {
//
//            }
            branches.append(Branch(a: a, b: x, graph: aSubGraph))
            
            // x - b
            let aIndex = (bIndex + 1) % 2
            let aSubset = subSets[aIndex]
            var bSubGraph = graph
            bSubGraph.remove(nodes: aSubset)
            bSubGraph.removeNode(index: a)
            branches.append(Branch(a: x, b: b, graph: bSubGraph))
            
            return .subBranches(branches)
        default:
            return .notValid
        }
    }
    
    func discoverMiddle(indices: [Int]) -> Result {
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
                    for index in 0..<subSets.count {
                        let subSet = subSets[index]
                        if !subSet.contains(a) && !subSet.contains(b) {
                            if mIndex == .empty {
                                mIndex = index
                            } else {
                                // must be only one
                                return .notValid
                            }
                        }
                    }
                    
                    var branches = [Branch]()
                    
                    // for middle
                    if mIndex != .empty {
                        var subSet = subSets[mIndex]
                        subSet.insert(x0)
                        subSet.insert(x1)
                        let subtract = graph.nodes.set.subtracting(subSet)
                        var subGraph = graph
                        subGraph.remove(nodes: subtract)
                        
                        branches.append(Branch(a: x0, b: x1, graph: subGraph))
                    } else {
                        assert(subSets.count == 2)
                    }
                    
                    // for side
                    for index in 0..<subSets.count where index != mIndex {
                        var subSet = subSets[index]
                        guard subSet.count > 1 else { continue }
                        
                        let c: Int
                        if subSet.contains(a) {
                            c = a
                        } else {
                            assert(subSet.contains(b))
                            c = b
                        }

                        let node = graph.nodes[c]
                        let x = node.contains(x0) ? x1 : x0

                        subSet.insert(x)
                        let subtract = graph.nodes.set.subtracting(subSet)
                        var subGraph = graph
                        subGraph.remove(nodes: subtract)

                        branches.append(Branch(a: c, b: x, graph: subGraph))
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

    private mutating func removeEnds() {
        var ax = a
        var node = graph.nodes[ax]
        while node.count < 2 && graph.nodes.count > 2 && node.first != b {
            graph.removeNode(index: ax)
            ax = node.first
            node = graph.nodes[ax]
        }
        if ax != a {
            a = ax
        }
        
        var bx = b
        node = graph.nodes[bx]
        while node.count < 2 && graph.nodes.count > 2 && node.first != a {
            graph.removeNode(index: bx)
            bx = node.first
            node = graph.nodes[bx]
        }
        if bx != b {
            b = bx
        }
    }

}
