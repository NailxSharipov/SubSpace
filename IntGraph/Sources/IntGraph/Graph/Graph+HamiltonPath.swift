//
//  Graph+HamiltonPath.swift
//  
//
//  Created by Nail Sharipov on 27.11.2021.
//

public extension Graph {
    
    func isHamiltonianPathExist(a: Int, b: Int) -> Bool {
        guard self.isHamiltonianQualifiedVertices(a: a, b: b) else {
            return false
        }

        guard self.isConnective(a: a, b: b) else {
            return false
        }
        
        return validatePath(a: a, b: b)
    }
   
    private func isHamiltonianQualifiedVertices(a: Int, b: Int) -> Bool {
        let isContain = nodes.contains(where: { index, node in
            if index == a || index == b {
                return node.count == 0
            } else {
                return node.count < 2
            }
        })
        
        return !isContain && nodes.count == size
    }

    private func isContainLoops(a: Int, b: Int, subSet: IntSet) -> Bool {
        var subGraph = self
        let rest = self.nodes.set.subtracting(subSet)
        subGraph.remove(nodes: rest)
        
        return subGraph.isContainLoops(a: a, b: b)
    }

    private func validatePath(a: Int, b: Int) -> Bool {
        let indices = nodes.set.sequence
        var weakNodeSet = IntSet(size: size)

        for i in indices {
            let subSets = self.split(node: i)
            guard i != a && i != b else {
                let opposite = i == a ? b : a
                if subSets.contains(where: { !$0.contains(opposite) }) {
                    return false
                }
                
                continue
            }
            
            guard subSets.count <= 2, !subSets.contains(where: { !($0.contains(a) || $0.contains(b)) }) else {
                return false
            }
            
            if subSets.count == 2, nodes[i].count > 2 {
                weakNodeSet.insert(i)
            }
        }

        guard weakNodeSet.count > 0 else {
            let hasLoop = self.isContainLoops(a: a, b: b)
            return !hasLoop
        }
        
        // break original graph into sub graphs a ... w0 ... w1 ... wN ... b
        
        weakNodeSet.remove(a)  // remove !!!
        weakNodeSet.remove(b)  // remove !!!
        var w0 = a
        
        var buffer = nodes[a]
        var visited = IntSet(size: size)
        visited.insert(a)
        visited.formUnion(buffer)
        
        var next = IntSet(size: size)
        var restGraph = self

        while !weakNodeSet.isEmpty {
            let common = buffer.intersection(weakNodeSet)
            if common.isEmpty {
                buffer.forEach { index in
                    next.formUnion(nodes.buffer[index])
                }
                buffer = next.subtracting(visited)
                visited.formUnion(buffer)
            } else {
                let w1 = common.first
                
                var subSet = restGraph.connected(a: w0, visited: IntSet(size: size, array: [w0, w1]))
                let subtract = restGraph.nodes.set.subtracting(subSet)
                var subGraph = restGraph
                subGraph.remove(nodes: subtract)
                
                let isValid = subGraph.validatePath(a: w0, b: w1)
                if !isValid {
                    return false
                }
                subSet.remove(w1)
                restGraph.remove(nodes: subSet)
                
                
                visited.formUnion(subSet)
                buffer = nodes[w1].subtracting(visited)
                
                w0 = w1
                weakNodeSet.remove(w1)
            }
            next.removeAll()
        }

        let isValid = restGraph.validatePath(a: w0, b: b)

        return isValid
    }
    
    // rename
    private func isContainLoops(a: Int, b: Int) -> Bool {
        let indices = self.nodes.set.sequence

        for ei in 0..<indices.count - 1 {
            let i = indices[ei]
            let ni = nodes[i]
            assert(ni.count > 0)
            let isEnd_i = i == a || i == b
            guard ni.count > 2 || isEnd_i else {
                continue
            }
            
            for ej in ei + 1..<indices.count {
                let j = indices[ej]
                let nj = nodes[j]
                assert(nj.count > 0)
                let isEnd_j = j == a || j == b
                guard nj.count > 2 || isEnd_j else {
                    continue
                }
                
                let subSets = self.split(a: i, b: j)

                let n = subSets.count
                
                guard n > 1 else {
                    continue
                }
                
                let isOneEnd = isEnd_i || isEnd_j
                let isTwoEnd = isEnd_i && isEnd_j
                
                if n > 3 || n > 2 && isOneEnd || isTwoEnd {
                    return true
                }
                
                struct SubSetData {
                    let a: Int
                    let b: Int
                    let subSet: IntSet
                }
                
                var subSetData = [SubSetData]()
                subSetData.reserveCapacity(subSets.count)
                
                var iCount = 0
                var jCount = 0
                var ijCount = 0
                
                // each of subset must have Hamilton path
                for k in 0..<subSets.count {
                    var subSet = subSets[k]

                    var isXi = false
                    var isXj = false
                    
                    for s in subSet.sequence {
                        let n = nodes[s]
                        if !isXi && n.contains(i) {
                            subSet.insert(i)
                            isXi = true
                        }
                        if !isXj && n.contains(j) {
                            isXj = true
                            subSet.insert(j)
                        }
                    }
                    
                    // is contain all nodes except ends
                    if subSet.count == nodes.count - 2 && !subSet.contains(a) && !subSet.contains(b) {
                        var subGraph = self
                        subGraph.removeNode(index: a)
                        subGraph.removeNode(index: b)
                        let isHamiltonPath = subGraph.validatePath(a: i, b: j)
                        if !isHamiltonPath {
                            return true
                        }
                        
                        return false
                    }
                    
                    assert(isXi || isXj)
                    
                    if isXi && isXj {
                        subSetData.append(.init(a: i, b: j, subSet: subSet))
                        ijCount += 1
                    } else {
                        let c = subSet.contains(a) ? a : b
                        if isXi {
                            iCount += 1
                            subSetData.append(.init(a: i, b: c, subSet: subSet))
                        } else {
                            jCount += 1
                            subSetData.append(.init(a: j, b: c, subSet: subSet))
                        }
                    }
                }
                
                if iCount > 1 || jCount > 1 {
                    return true
                }

                for item in subSetData {
                    let subtract = self.nodes.set.subtracting(item.subSet)
                    var subGraph = self
                    subGraph.remove(nodes: subtract)

                    let isHamiltonPath = subGraph.validatePath(a: item.a, b: item.b)
                    if !isHamiltonPath {
                        return true
                    }
                }
                
                return false
            }
        }

        return false
    }
    
}
