//
//  File.swift
//  
//
//  Created by Nail Sharipov on 05.11.2021.
//

import CoreGraphics

public struct AdMatrix {
    
    let size: Int
    let buffer: [Int]
    
    @inline(__always)
    subscript(i: Int, j: Int) -> Int {
        buffer[index(i, j)]
    }
    
    @inline(__always)
    public func index(_ i: Int, _ j: Int) -> Int {
        Self.index(i, j, size: size)
    }
    
    @inline(__always)
    static func index(_ i: Int, _ j: Int, size: Int) -> Int {
        i * size + j
    }
    
    public init(array: [Int]) {
        let n = array.count
        size = Int(Double(n).squareRoot().rounded())
        buffer = array
        assert(size * size == n)
    }
    
    func isCross(a: Int, b: Int, c: Int, d: Int) -> Bool {
        let ac = self[a, c]
        let bd = self[b, d]
        
        let bc = self[b, c]
        let da = self[d, a]
        
        let ab = self[a, b]
        let cd = self[c, d]
        
        let abcd = ab + cd
        let acbd = ac + bd
        let bcda = bc + da

        return abcd > acbd && abcd > bcda
    }
    
    func isDirectCross(a: Int, b: Int, c: Int, d: Int) -> Bool {
        let ac = self[a, c]
        let bd = self[b, d]
        
        let ab = self[a, b]
        let cd = self[c, d]
        
        let abcd = ab + cd
        let acbd = ac + bd

        return abcd > acbd
    }
}
