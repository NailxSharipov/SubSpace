//
//  AdMatrix+Contour.swift
//  
//
//  Created by Nail Sharipov on 11.11.2021.
//

public extension AdMatrix {
    
    func findContour() -> [Int] {
        var excludes = self.excludeMiddles()

        return excludes
    }

    public func excludeMiddles() -> [Int] {
//        var map = ConMap(size: size)
//        map.excludeCross(matrix: self)
//        map.excludeChordes(matrix: <#AdMatrix#>)
//
//        var connections = map.findMaxConnections()
//        var subMat = SubMatrix(matrix: self, exclude: [])
//        var exclude = Set<Int>(connections.indices)
//        var hasMore = connections.count > 2
//
//        guard hasMore else {
//            return []
//        }
//
//        repeat {
//            subMat = SubMatrix(matrix: self, exclude: exclude)
//
//            map = ConMap(size: subMat.matrix.size)
//            map.excludeCross(matrix: subMat.matrix)
//            map.excludeChordes()
//
//            connections = map.findMaxConnections()
//
//            hasMore = connections.count > 2
//            if hasMore {
//                let orIndices = subMat.convertToOriginal(connections.indices)
//                exclude.formUnion(orIndices)
//            }
//        } while hasMore
//
//        return Array(exclude)
        return []
    }
    
}
