//
//  File.swift
//  
//
//  Created by Nail Sharipov on 07.11.2021.
//

public struct Edge: Hashable {
    
    public let a: Int
    public let b: Int
    
    public init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
}
