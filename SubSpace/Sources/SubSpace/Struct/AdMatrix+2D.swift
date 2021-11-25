//
//  File.swift
//  
//
//  Created by Nail Sharipov on 05.11.2021.
//

import CoreGraphics

public extension AdMatrix {
    
    static let defaultScale: CGFloat = 10000
    
    init(nodes: [CGPoint], scale: CGFloat = Self.defaultScale) {
        self.size = nodes.count
        let count = size * size
        var array = [Int](repeating: 0, count: count)
        for i in 0..<size - 1 {
            for j in (i + 1)..<size {
                let a = nodes[i]
                let b = nodes[j]
                let dx = a.x - b.x
                let dy = a.y - b.y
                let l = Int((dx * dx + dy * dy).squareRoot() * scale)
                
                let k0 = i * size + j
                let k1 = j * size + i
                
                array[k0] = l
                array[k1] = l
            }
        }
        self.buffer = array
    }
    
    func scale(length: Int, scale: CGFloat = Self.defaultScale) -> CGFloat {
        CGFloat(length) / scale
    }
    
}
