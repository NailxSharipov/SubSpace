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

        let indices = nodes.set.sequence
        var weakNodeSet = IntSet(size: size)

        for i in indices {
            let subSets = self.split(node: i)
            
            let n = subSets.count

            let node = nodes[i]
            if (n == 1 && (i == a || i == b)) || node.count == 2 {
                continue
            }
            
            guard n == 2 else {
                return false
            }
            
            // less then 2 subset is not possible cause isHamiltonianQualifiedVertices condition

            let sub0 = subSets[0]
            let sub1 = subSets[1]

            guard (sub0.contains(a) || sub0.contains(b)) && (sub1.contains(a) || sub1.contains(b)) else {
                return false
            }
            
            weakNodeSet.insert(i)
        }

        guard weakNodeSet.count > 0 else {
            let hasLoop = self.isContainLoops(a: a, b: b)
            return !hasLoop
        }
        
        // break original graph into sub graphs a ... w0 ... w1 ... wN ... b
        
        weakNodeSet.remove(a)
        weakNodeSet.remove(b)
        var w0 = a
        
        var buffer = nodes[a]
        var visited = IntSet(size: size)
        visited.insert(a)
        visited.formUnion(buffer)
        
        var next = IntSet(size: size)
        var subSet = IntSet(size: size)
        subSet.insert(a)

        while !weakNodeSet.isEmpty {
            let common = buffer.intersection(weakNodeSet)
            if common.isEmpty {
                subSet.formUnion(buffer)
            } else {
                let w1 = common.first
                let hasLoop = self.isContainLoops(a: w0, b: w1, subSet: subSet)
                if hasLoop {
                    return false
                }
                w0 = w1
                weakNodeSet.remove(w1)
                subSet.removeAll()
                subSet.insert(w1)
            }
            
            buffer.forEach { index in
                next.formUnion(nodes.buffer[index])
            }
            buffer = next.subtracting(visited)
            visited.formUnion(buffer)
            next.removeAll()
        }
        
        let hasLoop = self.isContainLoops(a: w0, b: b, subSet: subSet)
        
        return !hasLoop
    }
    
    private func isHamiltonianQualifiedVertices(a: Int, b: Int) -> Bool {
        let index = nodes.firstIndex(where: { index, node in
            node.count < 2 && index != a && index != b
        })
        return index == .empty
    }

    private func isContainLoops(a: Int, b: Int, subSet: IntSet) -> Bool {
        var subGraph = self
        let rest = self.nodes.set.subtracting(subSet)
        subGraph.remove(nodes: rest)
        
        return subGraph.isContainLoops(a: a, b: b)
    }
    
    private func isContainLoops(a: Int, b: Int) -> Bool {
        let indices = self.nodes.set.sequence
        
        var skipSet = IntSet(size: size)
        
        for i in 0..<indices.count - 1 where !skipSet.contains(i) {
            guard nodes[i].count > 2 || i == a || i == b else {
                continue
            }
            
            for j in i + 1..<indices.count where !skipSet.contains(j) {
                guard nodes[j].count > 2 || j == a || j == b else {
                    continue
                }
                
                let subSets = self.split(a: i, b: j)
                
                let n = subSets.count
                guard n >= 2 else {
                    continue
                }
                
                if (i == a || i == b) && (j == a || j == b) {
                    return true
                }

                guard n > 3 || (i == a || i == b || j == a || j == b) else {
                    return true
                }

                // иначе ищем центральный subset и добавляем его в посещенные
                
                if var middle = subSets.first(where: { !$0.contains(a) && $0.contains(b) }) {
                    middle.insert(i)
                    middle.insert(j)
                    let hasLoop = isContainLoops(a: i, b: j, subSet: middle)
                    if hasLoop {
                        return true
                    }
                    
                    skipSet.formUnion(middle)
                }
            }
        }

        return false
    }
    
}
