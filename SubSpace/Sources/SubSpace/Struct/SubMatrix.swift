//
//  SubMatrix.swift
//  
//
//  Created by Nail Sharipov on 12.11.2021.
//

struct SubMatrix {

    let matrix: AdMatrix
    let indexMap: [Int]
    
    func convertToOriginal(_ array: [Int]) -> [Int] {
        var buffer = [Int]()
        for a in array {
            buffer.append(indexMap[a])
        }
        return buffer
    }
    
    init(matrix origin: AdMatrix, exclude: Set<Int>) {
        var indexMap = [Int]()
        
        for i in 0..<origin.size where !exclude.contains(i) {
            indexMap.append(i)
        }
        
        let n = origin.size - exclude.count
        var array = [Int](repeating: 0, count: n * n)
        
        for i in 0..<n {
            let oi = indexMap[i]
            for j in 0..<n {
                let oj = indexMap[j]
                let index = AdMatrix.index(i, j, size: n)
                array[index] = origin[oi, oj]
            }
        }
        
        matrix = AdMatrix(array: array)
        self.indexMap = indexMap
    }

}
